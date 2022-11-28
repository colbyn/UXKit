//
// Created by Colbyn Wadman on 11/20/22.
//

import UIKit
import Combine


public struct UX {}
public struct I {}
internal struct Backend {}

extension I {
    typealias CommitID = Int
    fileprivate struct Commit<T> {
        let commitID: CommitID
        var data: T
    }
}

extension I {
    final class List<Element> {
        typealias Index = Int
        fileprivate struct ItemHistory {
            let start: Commit<Element>
            var edits: Array<Commit<Element>> = []
            var deleted: Commit<()>? = nil
            var head: Element? {
                if deleted.isSome {
                    return nil
                }
                if let last = edits.last {
                    return last.data
                }
                return start.data
            }
            var isDeleted: Bool {
                deleted.isSome
            }
        }
        fileprivate var currentCommitID: CommitID = 0
        fileprivate var commits: Array<ItemHistory> = []
    }
}

extension I.List {
    convenience init(from array: Array<Element>) {
        self.init()
        for element in array {
            append(newElement: element)
        }
    }
}

extension I.List {
    func get(index: Index) -> Element? {
        if let real = getRealIndex(index: index) {
            return commits[real].head
        }
        return nil
    }
    func append(newElement: Element) {
        commits.append(ItemHistory(start: I.Commit(commitID: self.currentCommitID, data: newElement)))
    }
    func set(index: Index, newElement: Element) -> Element? {
        update(index: index) {_ in newElement}
    }
    func update(index: Index, _ f: (Element) -> Element) -> Element? {
        if let real = getRealIndex(index: index) {
            if let head = commits[real].head {
                commits[real].edits.append(I.Commit(commitID: currentCommitID, data: f(head)))
            }
        }
        return nil
    }
    func swap(i: Index, j: Index) {
        let ir = getRealIndex(index: i)!
        let jr = getRealIndex(index: j)!
        assert(commits[ir].deleted.isNone)
        assert(commits[jr].deleted.isNone)
        commits[ir].edits.append(I.Commit(
                commitID: currentCommitID,
                data: commits[jr].head!
        ))
        commits[jr].edits.append(I.Commit(
                commitID: currentCommitID,
                data: commits[ir].head!
        ))
    }
}

extension I.List {
    fileprivate func getRealIndex(index: Index) -> Index? {
        var counter: Int = 0
        for commit in commits {
            if commit.isDeleted {
                continue
            }
            if index == counter {
                return counter
            }
            counter = counter + 1
        }
        return nil
    }
    public var count: Int {
        var counter: Int = 0
        for commit in commits {
            if commit.isDeleted {
                continue
            }
            counter = counter + 1
        }
        return counter
    }
    public var indices: Range<Index> {
        let myNSRange = NSRange(location: 0, length: count)
        return Range.init(myNSRange)!
    }
    private func toArray() -> Array<Element> {
        var xs: Array<Element> = []
        for commit in commits {
            if let head = commit.head {
                xs.append(head)
            }
        }
        return xs
    }
}

extension I.List: Decodable where Element: Decodable {
    convenience init(from decoder: Decoder) throws {
        let values = try Array<Element>.init(from: decoder)
        self.init(from: values)
    }
}

extension I.List: Encodable where Element: Encodable {
    func encode(to encoder: Encoder) throws {
        let values = toArray()
        try values.encode(to: encoder)
    }
}

extension I {
    final class Signal<Value> {
        fileprivate let start: Commit<Value>
        fileprivate var commits: Array<Commit<Value>> = []
        fileprivate var currentCommitID: CommitID = 0
        init(value: Value) {
            start = Commit(commitID: 0, data: value)
        }
        var head: Value {
            if let last = commits.last {
                return last.data
            }
            return start.data
        }
    }
}

protocol HasTypeID {
    static var typeID: UUID {get}
}

protocol DefaultValue {
    static var defaultValue: Self {get}
}

protocol UXDownstreamKey {
    associatedtype Value
    static var defaultValue: Self.Value {get}
}

struct UXDownstreamDictionary {}


extension UX {
    final class Downstream {
        static func copy(_ value: Downstream) -> Downstream {
            let newValue = Downstream()
            newValue.storage = value.storage
            return newValue
        }
        private var storage: [ObjectIdentifier: Any] = [:]
        subscript<Key>(key: Key.Type) -> Key.Value where Key: UXDownstreamKey {
            get {
                if let value = self.storage[ObjectIdentifier(key)] {
                    return value as! Key.Value
                }
                return Key.defaultValue
            }
            set { self.storage[ObjectIdentifier(key)] = newValue }
        }
        @discardableResult
        func set<Key: UXDownstreamKey>(key: Key.Type, value: Key.Value) -> Downstream {
            self[key] = value
            return self
        }
        @discardableResult
        func map<Key: UXDownstreamKey>(key: Key.Type, f: (Key.Value) -> Key.Value) -> Downstream {
            self[key] = f(self[key])
            return self
        }
    }
}

extension UX.Downstream {
    struct FontStyleKey: UXDownstreamKey {
        typealias Value = UX.FontStyle
        static var defaultValue = UX.FontStyle.default()
    }
}

internal protocol UXViewBackend {
    func start()
    func tick()
}

protocol ToTableViewConfig {
    func toTableViewConfig() -> UX.TableViewConfig
}
extension String: ToTableViewConfig {
    func toTableViewConfig() -> UX.TableViewConfig {
        return UX.TableViewConfig().with(text: I.Signal.init(value: self))
    }
}
extension I.Signal: ToTableViewConfig where Value == String  {
    func toTableViewConfig() -> UX.TableViewConfig {
        return UX.TableViewConfig().with(text: self)
    }
}
extension UX.Label: UXViewBackend {
    func start() {
        self.viewBackend.text = self.text.head
    }
    func tick() {}
}
extension UX {
    class TableViewConfig {
        var text: I.Signal<String>? = nil
        @discardableResult
        func with(text: I.Signal<String>) -> TableViewConfig {
            self.text = text
            return self
        }
    }
    final class Label {
        let text: I.Signal<String>
        fileprivate let viewBackend: UILabel = UILabel()
        init(text: I.Signal<String>) {
            self.text = text
        }
        init(text: String) {
            self.text = I.Signal.init(value: text)
        }
    }
}

extension UX {
    final class TableView<Element> where Element: ToTableViewConfig {
        fileprivate let list: I.List<Element>
        fileprivate let viewBackend: UITableView = UITableView()
        fileprivate let dataSource: DataSource = DataSource()
        init(list: I.List<Element>) {
            self.list = list
        }
    }
}

extension UX.TableView: UXViewBackend {
    func start() {
        dataSource.list = self.list
        viewBackend.register(UITableViewCell.self, forCellReuseIdentifier: dataSource.cellReuseIdentifier)
        viewBackend.dataSource = dataSource
        viewBackend.delegate = dataSource
    }
    func tick() {
        
    }
}

extension UX.TableView {
    internal final class DataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
        var list: I.List<Element>!
        var cellReuseIdentifier: String = "MyCell"
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            list.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath as IndexPath)
            var config = cell.defaultContentConfiguration()
            let elementConfig = list.get(index: indexPath.row)!.toTableViewConfig()
            if let text = elementConfig.text {
                config.text = text.head
            }
            cell.contentConfiguration = config
            return cell
        }
    }
}


//extension UX.TableViewCell: UXViewBackend {
//    typealias ViewBackend = UITableViewCell
//    var viewBackend: UITableViewCell {UITableViewCell()}
//    func start() {
//        var content = viewBackend.defaultContentConfiguration()
//        content.text = text?.head
//        viewBackend.contentConfiguration = content
//    }
//    func tick() {}
//}


class PrototypeViewController: UIViewController {
    var list: I.List<String> = I.List.init(from: [
        "Alpha",
        "Beta",
        "Gamma",
    ])
    var tableView: UX.TableView<String>!
    override func viewDidLoad() {
        tableView = UX.TableView(list: list)
        tableView.start()
        tableView.viewBackend.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView.viewBackend)
        NSLayoutConstraint.activate([
            tableView.viewBackend.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.viewBackend.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.viewBackend.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.viewBackend.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
    }
}



class Tools: ObservableObject {
    private var tools: Array<Tool> = []
    struct Tool {}
}



struct IArray<T> {
    private var data: Array<T>
    init(_ data: Array<T>) {
        self.data = data
    }
}


