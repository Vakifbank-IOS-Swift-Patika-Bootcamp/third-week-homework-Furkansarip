//
//  EmployeeViewCell.swift
//  CompanyApp
//
//  Created by Furkan Sarı on 17.11.2022.
//

import UIKit

class EmployeeViewCell: UITableViewCell {

    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
