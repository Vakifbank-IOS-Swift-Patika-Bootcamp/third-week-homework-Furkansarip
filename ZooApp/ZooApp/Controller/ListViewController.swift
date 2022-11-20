//
//  ListViewController.swift
//  ZooApp
//
//  Created by Furkan Sarı on 20.11.2022.
//

import UIKit
import AVFoundation

class ListViewController: UIViewController {
    
    @IBOutlet weak var animalTableView: UITableView!
    @IBOutlet weak var keeperTableView: UITableView!
    var keeperArray = [Keeper]()
    var animalArray = [Animal]()
    var player : AVAudioPlayer?
    var animalSound = ""
    override func viewDidLoad() {
        
        super.viewDidLoad()
        keeperArray = Zoo.shared.allKeeperList()
        animalArray = Zoo.shared.allAnimalList()
        animalTableView.dataSource = self
        animalTableView.delegate = self
        print(keeperArray.count)
        keeperTableView.delegate = self
        keeperTableView.dataSource = self
        
        keeperTableView.register(UINib(nibName: "KeeperViewCell", bundle: nil), forCellReuseIdentifier: "KeeperCell")
        animalTableView.register(UINib(nibName: "AnimalViewCell", bundle: nil), forCellReuseIdentifier: "AnimalCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        animalTableView.reloadData()
        keeperTableView.reloadData()
    }
    func animalVoice(animalType : String) {//Hayvan seslerinin çalıştırıldığı fonksiyon
        guard let sound = Bundle.main.url(forResource: animalType, withExtension: "wav") else { return }
        player = try! AVAudioPlayer(contentsOf: sound)
        player?.play()
    }

}



extension ListViewController : UITableViewDelegate,UITableViewDataSource {//Dinamik tableView yapısı
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case keeperTableView:
            return keeperArray.count
        case animalTableView:
            return animalArray.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {//Yapıya göre cell oluşturuluyor.
    let defaultCell = UITableViewCell()
        print(tableView)
        switch tableView {
        case keeperTableView:
           let cell = keeperTableView.dequeueReusableCell(withIdentifier: "KeeperCell", for: indexPath) as! KeeperViewCell
            cell.salaryLabel.text = "\(keeperArray[indexPath.row].salary)"
            cell.fullNameLabel.text = keeperArray[indexPath.row].name
            return cell
        case animalTableView:
            let cell = animalTableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath) as! AnimalViewCell
            cell.animalNameLabel.text = animalArray[indexPath.row].animalType
            cell.keeperNameLabel.text = animalArray[indexPath.row].keeper.name
            return cell
            
        default:
            print("error")
        }
        return defaultCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // Seçili hayvanın ses çalma işlemi
        switch tableView {
        case animalTableView:
            animalSound = animalArray[indexPath.row].animalType
            print(animalSound)
            animalVoice(animalType: animalSound)
        default:
            print("Keeper Array")
        }
    }
    
    
}
