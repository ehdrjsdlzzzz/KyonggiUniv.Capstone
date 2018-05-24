//
//  ItemCategoryViewController.swift
//  CapstoneProject
//
//  Created by 이동건 on 2018. 5. 24..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class ItemCategoryViewController: UIViewController {
    
    var category:Category!
    init(category: Category) {
        super.init(nibName: nil, bundle: nil)
        self.category = category
        self.title = "\(category.rawValue) 선택"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    fileprivate func setupNavigationBar(){
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = UIColor.themeLightSkin
        self.navigationController?.navigationBar.tintColor = UIColor.themeDarkBlue
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.themeDarkBlue]
        self.navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "home"), style: .plain, target: self, action: #selector(handleDismiss(_:)))
    }
    
    fileprivate func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.themeLightSkin
    }
    
    @objc func handleDismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension ItemCategoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerTitle = view as? UITableViewHeaderFooterView {
            headerTitle.textLabel?.textColor = UIColor.themeDarkBlue
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch category {
        case .Brand :
            return "브랜드"
        case .Card :
            return "카드사"
        default :
            return nil
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.themeLightSkin
        cell.accessoryView = UIImageView(image: #imageLiteral(resourceName: "right_arrow"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
