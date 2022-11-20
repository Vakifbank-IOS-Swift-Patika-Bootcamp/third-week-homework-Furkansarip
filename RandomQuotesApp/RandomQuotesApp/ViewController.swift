//
//  ViewController.swift
//  RandomQuotesApp
//
//  Created by Furkan Sarı on 20.11.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var quotesLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        randomQuotes()
    }

    
    func randomQuotes(){
        NetworkManager.shared.getQuotes { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let quotes):
                DispatchQueue.main.async {
                    self.quotesLabel.text = quotes.en
                    self.authorLabel.text = "Author : \(quotes.author)"
                }
            case .failure(let error):
                print(error)
                
            }
        }
    }

    @IBAction func randomQuotesButton(_ sender: Any) {
        randomQuotes()
    }
    
    
}

