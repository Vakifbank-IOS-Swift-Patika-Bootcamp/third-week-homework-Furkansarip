//
//  Company.swift
//  CompanyApp
//
//  Created by Furkan Sarı on 15.11.2022.
//

import Foundation

struct Company {
    static var shared = Company()
    private init(){}
    var employeeList = [Employee]()
    var mainSalary = 5500.0
    mutating func addEmployee(employee:Employee){
        employeeList.append(employee)
    }
    
   func payEmployeeSalary()->Double{
        var totalSalary = 0.0
        for employee in employeeList {
            totalSalary += employee.salary 
        }
        return totalSalary
    }
    
    func allEmployee()->[Employee]{
        return employeeList
    }
    
    
    
}
