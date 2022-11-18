//
//  IOSApp.swift
//  UXKitGenesis (iOS)
//
//  Created by Colbyn Wadman on 11/18/22.
//

import UIKit


typealias RootViewController = ViewController


//class ReactiveList<T>: NSObject, UITableViewDataSource, UITableViewDelegate {
//    var data: Array<T>!
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//}


class ViewController: UITableViewController {
    private var myArray: Array<String> = RANDOM_ARRAY_OF_STRINGS
    override func viewDidLoad() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(myArray[indexPath.row])")
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
//        let cell = UITableViewCell.init(style: UITableViewCell.CellStyle.value2, reuseIdentifier: "MyCell")
        cell.textLabel!.text = "\(myArray[indexPath.row])"
        cell.showsReorderControl = true
        return cell
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            self.myArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.left)
            tableView.endUpdates()
        }
    }
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.myArray[sourceIndexPath.row]
        self.myArray.remove(at: sourceIndexPath.row)
        self.myArray.insert(movedObject, at: destinationIndexPath.row)
    }
}

//class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    private var myArray: Array<String> = ["First","Second","Third"]
//    private var myTableView: UITableView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
////        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
//
//
////        let displayWidth: CGFloat = self.view.frame.width
////        let displayHeight: CGFloat = self.view.frame.height
//
////        myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight - barHeight))
//        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
//        myTableView.dataSource = self
//        myTableView.delegate = self
//        self.view.addSubview(myTableView)
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Num: \(indexPath.row)")
//        print("Value: \(myArray[indexPath.row])")
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return myArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
//        cell.textLabel!.text = "\(myArray[indexPath.row])"
//        return cell
//    }
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            tableView.beginUpdates()
//            self.myArray.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.left)
//            tableView.endUpdates()
//        }
//    }
//}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        windowScene.title = "My App"
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = RootViewController()
        self.window = window
        window.makeKeyAndVisible()
    }
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        if connectingSceneSession.role == UISceneSession.Role.windowApplication {
            let config = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
            config.delegateClass = AppDelegate.self
            return config
        }
        fatalError("Unhandled scene role \(connectingSceneSession.role)")
    }
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow()
        window!.rootViewController = RootViewController()
        window!.makeKeyAndVisible()
        return true
    }
}


//extension UIView {
//    required convenience init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}


struct I {}



typealias BaseView = BaseViewClass

class BaseViewClass: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: CGRect.zero)
    }
}


class Toolbar: BaseView {
    var stackView: UIStackView = UIStackView()
    override init() {
        super.init()
        let view1 = UILabel()
        view1.text = "Hello World"
    }
}


class SVGPathShape: BaseView {
    var pathString: String!
    var xAxisRange: (CGFloat, CGFloat)!
    var yAxisRange: (CGFloat, CGFloat)!
    
    required init(
        xAxisRange: (CGFloat, CGFloat),
        yAxisRange: (CGFloat, CGFloat),
        pathString: String
    ) {
        super.init()
        self.xAxisRange = xAxisRange
        self.yAxisRange = yAxisRange
        self.pathString = pathString
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        var parser = Parser(path: self.pathString)
        let commands = parser.run()
        let xScale = LinearScale(
            domain: self.xAxisRange,
            range: (rect.minX, rect.maxX)
        )
        let yScale = LinearScale(
            domain: self.yAxisRange,
            range: (rect.minY, rect.maxY)
        )
        for cmd in commands {
            switch cmd {
            case .move(let moveCmd):
                let point = CGPoint(
                    x: xScale.scale(moveCmd.to.x),
                    y: yScale.scale(moveCmd.to.y)
                )
                context.move(to: point)
            case .line(let lineCmd):
                let point = CGPoint(
                    x: xScale.scale(lineCmd.to.x),
                    y: yScale.scale(lineCmd.to.y)
                )
                context.addLine(to: point)
            case .curve(let curveCmd):
                let control1 = CGPoint(
                    x: xScale.scale(curveCmd.control1.x),
                    y: yScale.scale(curveCmd.control1.y)
                )
                let control2 = CGPoint(
                    x: xScale.scale(curveCmd.control2.x),
                    y: yScale.scale(curveCmd.control2.y)
                )
                let to = CGPoint(
                    x: xScale.scale(curveCmd.to.x),
                    y: yScale.scale(curveCmd.to.y)
                )
                context.addCurve(to: to, control1: control1, control2: control2)
            }
        }
    }
    
    struct Parser {
        var value: Array<String>
        init(path: String) {
            var results: Array<String> = []
            for chunk in path.split(separator: " ") {
                results.append("\(chunk)")
            }
            self.value = results
        }
        struct MoveCmd {
            let to: CGPoint
        }
        struct LineCmd {
            let to: CGPoint
        }
        struct CurveCmd {
            let control1: CGPoint
            let control2: CGPoint
            let to: CGPoint
        }
        enum PathCmd {
            case move(MoveCmd)
            case line(LineCmd)
            case curve(CurveCmd)
        }
        mutating func extract<T>(_ f: (String) -> T?) -> T? {
            if let first = self.value.first {
                if let parsed = f(first) {
                    let poped = self.value.removeFirst()
                    assert(poped == first)
                    return parsed
                }
            }
            return nil
        }
        mutating func int() -> Double? {
            return self.extract({Double($0)})
        }
        mutating func letter(_ letter: Character) -> Character? {
            return self.extract({
                if $0 == "\(letter)" {
                    return letter
                }
                return nil
            })
        }
        mutating func point() -> CGPoint? {
            guard let x = self.int() else {return nil}
            guard let y = self.int() else {return nil}
            return CGPoint(x: x, y: y)
        }
        mutating func cmd1(letter: Character) -> CGPoint? {
            guard let _: Character = self.letter(letter) else {
                return nil
            }
            guard let point: CGPoint = self.point() else {
                return nil
            }
            return point
        }
        mutating func moveCmd() -> MoveCmd? {
            guard let point = self.cmd1(letter: "M") else {
                return nil
            }
            return MoveCmd(to: point)
        }
        mutating func lineCmd() -> LineCmd? {
            guard let point = self.cmd1(letter: "L") else {
                return nil
            }
            return LineCmd(to: point)
        }
        mutating func curveCmd() -> CurveCmd? {
            guard let _: Character = self.letter("C") else {
                return nil
            }
            guard let control1: CGPoint = self.point() else {
                return nil
            }
            guard let control2: CGPoint = self.point() else {
                return nil
            }
            guard let to: CGPoint = self.point() else {
                return nil
            }
            return CurveCmd(control1: control1, control2: control2, to: to)
        }
        mutating func run() -> Array<PathCmd> {
            var cmds: Array<PathCmd> = []
            while !self.value.isEmpty {
                if let move = self.moveCmd() {
                    cmds.append(PathCmd.move(move))
                    continue
                }
                if let line = self.lineCmd() {
                    cmds.append(PathCmd.line(line))
                    continue
                }
                if let curve = self.curveCmd() {
                    cmds.append(PathCmd.curve(curve))
                    continue
                }
                fatalError("What to do? \(cmds) \(self.value)")
            }
            return cmds
        }
    }
}


//fileprivate struct SVGPathShape: Shape {
//    fileprivate let commands: Array<Parser.PathCmd>
//    fileprivate let xAxisRange: (CGFloat, CGFloat)
//    fileprivate let yAxisRange: (CGFloat, CGFloat)
//    init(
//        widthRange: (CGFloat, CGFloat),
//        heightRange: (CGFloat, CGFloat),
//        path: String
//    ) {
//        self.xAxisRange = widthRange
//        self.yAxisRange = heightRange
//        var parser = Parser(path: path)
//        self.commands = parser.run()
//    }
//    init(
//        width: CGFloat,
//        height: CGFloat,
//        path: String
//    ) {
//        self.xAxisRange = (0, width)
//        self.yAxisRange = (0, height)
//        var parser = Parser(path: path)
//        self.commands = parser.run()
//    }
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        let xScale = LinearScale(
//            domain: self.xAxisRange,
//            range: (rect.minX, rect.maxX)
//        )
//        let yScale = LinearScale(
//            domain: self.yAxisRange,
//            range: (rect.minY, rect.maxY)
//        )
//        for cmd in commands {
//            switch cmd {
//            case .move(let moveCmd):
//                let point = CGPoint(
//                    x: xScale.scale(moveCmd.to.x),
//                    y: yScale.scale(moveCmd.to.y)
//                )
//                path.move(to: point)
//            case .line(let lineCmd):
//                let point = CGPoint(
//                    x: xScale.scale(lineCmd.to.x),
//                    y: yScale.scale(lineCmd.to.y)
//                )
//                path.addLine(to: point)
//            case .curve(let curveCmd):
//                let control1 = CGPoint(
//                    x: xScale.scale(curveCmd.control1.x),
//                    y: yScale.scale(curveCmd.control1.y)
//                )
//                let control2 = CGPoint(
//                    x: xScale.scale(curveCmd.control2.x),
//                    y: yScale.scale(curveCmd.control2.y)
//                )
//                let to = CGPoint(
//                    x: xScale.scale(curveCmd.to.x),
//                    y: yScale.scale(curveCmd.to.y)
//                )
//                path.addCurve(to: to, control1: control1, control2: control2)
//            }
//        }
//        return path
//    }
//    struct Parser {
//        var value: Array<String>
//        init(path: String) {
//            var results: Array<String> = []
//            for chunk in path.split(separator: " ") {
//                results.append("\(chunk)")
//            }
//            self.value = results
//        }
//        struct MoveCmd {
//            let to: CGPoint
//        }
//        struct LineCmd {
//            let to: CGPoint
//        }
//        struct CurveCmd {
//            let control1: CGPoint
//            let control2: CGPoint
//            let to: CGPoint
//        }
//        enum PathCmd {
//            case move(MoveCmd)
//            case line(LineCmd)
//            case curve(CurveCmd)
//        }
//        mutating func extract<T>(_ f: (String) -> T?) -> T? {
//            if let first = self.value.first {
//                if let parsed = f(first) {
//                    let poped = self.value.removeFirst()
//                    assert(poped == first)
//                    return parsed
//                }
//            }
//            return nil
//        }
//        mutating func int() -> Double? {
//            return self.extract({Double($0)})
//        }
//        mutating func letter(_ letter: Character) -> Character? {
//            return self.extract({
//                if $0 == "\(letter)" {
//                    return letter
//                }
//                return nil
//            })
//        }
//        mutating func point() -> CGPoint? {
//            guard let x = self.int() else {return nil}
//            guard let y = self.int() else {return nil}
//            return CGPoint(x: x, y: y)
//        }
//        mutating func cmd1(letter: Character) -> CGPoint? {
//            guard let _: Character = self.letter(letter) else {
//                return nil
//            }
//            guard let point: CGPoint = self.point() else {
//                return nil
//            }
//            return point
//        }
//        mutating func moveCmd() -> MoveCmd? {
//            guard let point = self.cmd1(letter: "M") else {
//                return nil
//            }
//            return MoveCmd(to: point)
//        }
//        mutating func lineCmd() -> LineCmd? {
//            guard let point = self.cmd1(letter: "L") else {
//                return nil
//            }
//            return LineCmd(to: point)
//        }
//        mutating func curveCmd() -> CurveCmd? {
//            guard let _: Character = self.letter("C") else {
//                return nil
//            }
//            guard let control1: CGPoint = self.point() else {
//                return nil
//            }
//            guard let control2: CGPoint = self.point() else {
//                return nil
//            }
//            guard let to: CGPoint = self.point() else {
//                return nil
//            }
//            return CurveCmd(control1: control1, control2: control2, to: to)
//        }
//        mutating func run() -> Array<PathCmd> {
//            var cmds: Array<PathCmd> = []
//            while !self.value.isEmpty {
//                if let move = self.moveCmd() {
//                    cmds.append(PathCmd.move(move))
//                    continue
//                }
//                if let line = self.lineCmd() {
//                    cmds.append(PathCmd.line(line))
//                    continue
//                }
//                if let curve = self.curveCmd() {
//                    cmds.append(PathCmd.curve(curve))
//                    continue
//                }
//                fatalError("What to do? \(cmds) \(self.value)")
//            }
//            return cmds
//        }
//    }
//}






