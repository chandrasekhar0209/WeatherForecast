//
//  GenericTableViewController.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 25/08/21.
//

import UIKit

struct TableProperties {
    var rowHeight: CGFloat
    init(rowHeight: CGFloat = 44) {
        self.rowHeight = rowHeight
    }
}

class GenericTableViewController<T, Cell: UITableViewCell>: UITableViewController {
    var items: [T]
    var tableProperties: TableProperties
    var configure: (Cell, T, Int) -> Void
    var selectHandler: (T) -> Void
    var editHandler: (Int) -> Void
    var isDefaultCell: Bool = false
    init(items: [T], tableProperties: TableProperties = TableProperties(), isDefaultCell: Bool, configure: @escaping (Cell, T, Int) -> Void, selectHandler: @escaping (T) -> Void, editHandler: @escaping (Int) -> Void) {
        self.items = items
        self.configure = configure
        self.selectHandler = selectHandler
        self.editHandler = editHandler
        self.tableProperties = tableProperties
        self.isDefaultCell = isDefaultCell
        super.init(style: .plain)
        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        if isDefaultCell {
            self.tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        } else {
            self.tableView.register(UINib(nibName: "\(Cell.self)", bundle: nil), forCellReuseIdentifier: "\(Cell.self)")
        }
    }
    
    func updatesItems(items: [T]) {
        self.items = items
        self.tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableProperties.rowHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = isDefaultCell ? "Cell" : "\(Cell.self)"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        
        let item = items[indexPath.row]
        configure(cell, item, indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        selectHandler(item)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            editHandler(indexPath.row)
        }
    }
}
