//
//  CardSelectViewController.swift
//  CapstoneProject
//
//  Created by 이동건 on 2018. 5. 31..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class CardTypeViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    //MARK: Properties
    var types:[String] = []
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        tableView.backgroundColor = UIColor.themeLightSkin
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Card.identifier)
        self.title = "카드 유형"
        APIService.shared.requestCardType { (types) in
            self.types = types
            self.tableView.reloadData()
        }
    }
    //MARK: Preferences
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    //MARK: Setup
    fileprivate func setupNavigationBar(){
        self.navigationController?.setupSelectViewController()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "home"), style: .plain, target: self, action: #selector(handleDismiss(_:)))
    }
    //MARK: Target-Action
    @objc func handleDismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
//MARK:- TableView
extension CardTypeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Card.identifier, for: indexPath)
        cell.backgroundColor = UIColor.themeLightSkin
        cell.accessoryView = UIImageView(image: #imageLiteral(resourceName: "right_arrow"))
        cell.textLabel?.text = types[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let companySelectVC = CardCompanyViewController()
        CardSelectData.main.card_type = types[indexPath.row]
        navigationController?.pushViewController(companySelectVC, animated: true)
    }
}
