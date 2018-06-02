//
//  BrandSelectViewController.swift
//  CapstoneProject
//
//  Created by 이동건 on 2018. 5. 31..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class BrandSelectViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var brands:[Brand] = []
    lazy var dismissButton = UIBarButtonItem(title: "닫기", style: .done, target: self, action: #selector(handleDismiss))
    lazy var doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(handleDone))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        tableView.backgroundColor = UIColor.themeLightSkin
        tableView.allowsMultipleSelection = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Brand.identifier)
        title = "브랜드 선택"
        
        APIService.shared.requestStore { (brands) in
            self.brands = brands
            self.tableView.reloadData()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    
    fileprivate func setupNavigationBar(){
        self.navigationController?.setupSelectViewController()
        self.navigationItem.rightBarButtonItem = dismissButton
    }
    
    @objc func handleDismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleDone(_ sender: UIBarButtonItem){
        
        guard let indexPaths = tableView.indexPathsForSelectedRows else {return}
        var selectedBrands:[Brand] = UserDefaults.standard.loadBrands()
        indexPaths.forEach { (indexPath) in
            let index = indexPath
            if !selectedBrands.contains(where: {$0.store_name == brands[index.row].store_name}) {
                selectedBrands.append(brands[index.row])
            }
        }
        UserDefaults.standard.set(try? PropertyListEncoder().encode(selectedBrands), forKey: Brand.key)
        dismiss(animated: true, completion: nil)
    }
}

extension BrandSelectViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Brand.identifier, for: indexPath)
        cell.backgroundColor = UIColor.themeLightSkin
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        cell.accessoryView = UIImageView(image: #imageLiteral(resourceName: "uncheck"))
        cell.textLabel?.text = brands[indexPath.row].store_name.uppercased()
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "브랜드"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerTitle = view as? UITableViewHeaderFooterView {
            headerTitle.textLabel?.textColor = UIColor.themeDarkBlue
        }
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


