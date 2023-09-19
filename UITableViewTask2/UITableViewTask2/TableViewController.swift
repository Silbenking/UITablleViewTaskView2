//
//  TableViewController.swift
//  UITableViewTask2
//
//  Created by Сергей Сырбу on 19.09.2023.
//

import UIKit
import SnapKit

class TableViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil) // ставим nil  чтобы поиск отображался в этом же вью
    var conatactArray = [ContactModel(name: "Sergey", secondName: "Markin", number: "89121558899"),
                         ContactModel(name: "Masha", secondName: "Suchkova", number: "89121558899"),
                         ContactModel(name: "Irina", secondName: "Ivanova", number: "89121558899"),
                         ContactModel(name: "Fala", secondName: "Petrova", number: "89121558899"),
                         ContactModel(name: "Mala", secondName: "Gurova", number: "89121558899"),
                         ContactModel(name: "Inna", secondName: "Klim", number: "89121558899")]
    
    var filterContactArray = [ContactModel]()
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        searchCont()
    }
    func searchCont(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // число строк в секции
        if isFiltering {
           return filterContactArray.count
        }
       return conatactArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {fatalError()}
        var contact: ContactModel
        if isFiltering {
            contact = filterContactArray[indexPath.row]
        } else {
            contact = conatactArray[indexPath.row]
        }
        
        cell.configure(name: contact.name, secondName: contact.secondName, number: contact.number)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, complition in
            self.conatactArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            }
//            tableView.reloadData() // перезагружаем таблицу
        return UISwipeActionsConfiguration(actions: [deleteAction])
        }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

  
}
extension TableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    private func filterContentForSearchText(_ searchText: String){
        filterContactArray = conatactArray.filter({  //попадают отфильтрованные города по имени
            $0.name.contains(searchText)
        })
        tableView.reloadData()
    } // текст который будет вводится в поисковую строку, мы по нему и будем искать
     
}
