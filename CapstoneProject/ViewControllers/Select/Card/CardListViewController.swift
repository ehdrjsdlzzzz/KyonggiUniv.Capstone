//
//  CardListViewController.swift
//  CapstoneProject
//
//  Created by 이동건 on 2018. 5. 31..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class CardListViewController: UIViewController {
    
    var nameList:[String] = []
    var company:String!
    
    lazy var dismissButton = UIBarButtonItem(title: "닫기", style: .done, target: self, action: #selector(handleDismiss))
    lazy var doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(handleDone))
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        company = CardSelectData.main.card_company
        tableView.backgroundColor = UIColor.themeLightSkin
        tableView.allowsMultipleSelection = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Card.identifier)
        self.navigationController?.setupSelectViewController()
        self.navigationItem.rightBarButtonItem = dismissButton
        
        title = company
        
        APIService.shared.requestCardList(type: CardSelectData.main.card_type ?? "", company: company) { (nameList) in
            self.nameList = nameList
            self.tableView.reloadData()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    
    @objc func handleDismiss(_ sender: UIBarButtonItem){
        print("dimsiss")
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleDone(_ sender: UIBarButtonItem){
        guard let indexPaths = tableView.indexPathsForSelectedRows else {return}
        var selectedCards:[String] = []
        indexPaths.forEach({selectedCards.append(nameList[$0.row])})
        var cards:[Card] = UserDefaults.standard.loadCards()
        
        selectedCards.forEach { (name) in
            if !cards.contains(where: {$0.card_name == name}) {
                cards.append(Card(card_type: CardSelectData.main.card_type!, card_company: CardSelectData.main.card_company!, card_name: name))
            }else{
                print("Already registered card")
            }
        }
        UserDefaults.standard.set(try? PropertyListEncoder().encode(cards), forKey: Card.key)
        dismiss(animated: true, completion: nil)
    }
}

extension CardListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Card.identifier, for: indexPath)
        cell.backgroundColor = UIColor.themeLightSkin
        cell.accessoryView = UIImageView(image: #imageLiteral(resourceName: "uncheck"))
        cell.textLabel?.text = nameList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryView = UIImageView(image: #imageLiteral(resourceName: "check"))
        self.navigationItem.rightBarButtonItem =  tableView.indexPathsForSelectedRows != nil ? doneButton : dismissButton
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryView = UIImageView(image: #imageLiteral(resourceName: "uncheck"))
        self.navigationItem.rightBarButtonItem =  tableView.indexPathsForSelectedRows != nil ? doneButton : dismissButton
    }
}
