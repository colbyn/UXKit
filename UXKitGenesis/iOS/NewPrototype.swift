//
//  BasicPrototype.swift
//  UXKitGenesis (iOS)
//
//  Created by Colbyn Wadman on 11/21/22.
//

import UIKit

struct LL {}

extension LL {
    final class TableView<Section: Hashable, Item: Identifiable & ToTableViewConfig> {
        var dataSource: UITableViewDiffableDataSource<Section, Item.ID>!
        var tableView: UITableView = UITableView()
        var items: Dictionary<Item.ID, Item> = [:]
        var cellReuseIdentifier: String = "MyCell"
        init() {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
            dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: provision)
        }
        private func provision(_ tableView: UITableView, _ indexPath: IndexPath, _ itemIdentifier: Item.ID) -> UITableViewCell? {
            if let item = items[itemIdentifier] {
                let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) ?? UITableViewCell()
                var cellConfig = cell.defaultContentConfiguration()
                let itemConfig = item.toTableViewConfig()
                if let text = itemConfig.text {
                    cellConfig.text = text.head
                }
                return cell
            }
            return nil
        }
        func append(items newItems: [Item]) {
            for item in newItems {
                let itemID = item.id
                items[itemID] = item
            }
        }
        func update() {
            
        }
    }
}



