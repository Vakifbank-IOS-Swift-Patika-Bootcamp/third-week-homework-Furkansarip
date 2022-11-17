//
//  EmployeeListViewController.swift
//  CompanyApp
//
//  Created by Furkan Sarı on 14.11.2022.
//

import UIKit

class EmployeeListViewController: UIViewController {

    var employeeArray = [Employee]()
    var filteredEmployee = [Employee]()
    @IBOutlet weak var employeeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.placeholder = "Find a employee"
        search.searchBar.autocapitalizationType = .none
        navigationItem.searchController = search
        employeeTableView.delegate = self
        employeeTableView.dataSource = self
        employeeTableView.register(UINib(nibName: "EmployeeViewCell", bundle: nil), forCellReuseIdentifier: "EmployeeCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        employeeArray = Company.shared.allEmployee()
        filteredEmployee = employeeArray
        employeeTableView.reloadData()
    }

}

extension EmployeeListViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        employeeArray = filteredEmployee.filter({$0.name.lowercased() == text.lowercased() })
        if text == "" {
            employeeArray = filteredEmployee
        }
        employeeTableView.reloadData()
    }
    
}

extension EmployeeListViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = employeeTableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath) as! EmployeeViewCell
        cell.fullNameLabel.text = employeeArray[indexPath.row].name
        cell.salaryLabel.text = String(employeeArray[indexPath.row].salary)
        return cell
    }
    
    
}
