//
//  CardCompanyViewController.swift
//  CapstoneProject
//
//  Created by 이동건 on 2018. 5. 31..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class CardCompanyViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var companies:[String] = []
    var type:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.themeLightSkin
        self.navigationController?.setupSelectViewController()
        type = CardSelectData.main.card_type
        title = type
        APIService.shared.requestCardCompany(type: type) { (companies) in
            self.companies = companies
            self.tableView.reloadData()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
}

extension CardCompanyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.themeLightSkin
        cell.accessoryView = UIImageView(image: #imageLiteral(resourceName: "right_arrow"))
        cell.textLabel?.text = companies[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cardListVC = CardListViewController()
        CardSelectData.main.card_company = companies[indexPath.row]
        self.navigationController?.pushViewController(cardListVC, animated: true)
    }
}
