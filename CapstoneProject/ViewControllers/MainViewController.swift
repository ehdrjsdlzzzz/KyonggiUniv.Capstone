//
//  MainViewController.swift
//  CapstoneProject
//
//  Created by 이동건 on 2018. 4. 12..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

class MainViewController: UIViewController {
    //MARK: Outlets
    var favoritesCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.themeDarkBlue
        return collectionView
    }()
    var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Swagger", size: 16)
        label.textColor = UIColor.themeLightSkin
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var greetingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Swagger", size: 28)
        label.textColor = UIColor.themeLightSkin
        label.text = "It is good day to buy"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: Properties
    var locationManager:CLLocationManager = CLLocationManager()
    var beaconRegion:CLBeaconRegion!
    let center = UNUserNotificationCenter.current()
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        self.beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: beacons[0].uuid)!, identifier: beacons[0].identifier)
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            
        }
        initializeLocationManager()
        UNUserNotificationCenter.current().delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Setup Views
    fileprivate func setupViews(){
        setupNavigationBar()
        setupFavoritesCollectionView()
        self.view.backgroundColor = UIColor.themeDarkBlue
        self.view.addSubview(greetingLabel)
        self.view.addSubview(dateLabel)
        self.view.addSubview(favoritesCollectionView)
        dateLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        dateLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MMMM dd"
        dateLabel.text = formatter.string(from: Date())
        greetingLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        greetingLabel.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 4).isActive = true
    
        favoritesCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        favoritesCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        favoritesCollectionView.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 30).isActive = true
        favoritesCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
    }
    fileprivate func setupFavoritesCollectionView(){
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
        favoritesCollectionView.showsVerticalScrollIndicator = false
        favoritesCollectionView.isScrollEnabled = false
        favoritesCollectionView.register(UINib(nibName: CategoryCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: CategoryCell.reusableIdentifier)
    }
    fileprivate func setupNavigationBar(){
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = UIColor.themeDarkBlue
        self.navigationController?.navigationBar.tintColor = UIColor.themeOpaqueGray
        self.navigationController?.navigationBar.barStyle = .blackOpaque
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "setting"), style: .plain, target: self, action: #selector(handleSetting))
    }
//    @objc func handleSetting(){
//        
//    }
    
    @objc func handleAddBrand(_ sender: UIButton) {
        let itemCategoryVC = ItemCategoryViewController(category: .Brand)
        present(UINavigationController(rootViewController: itemCategoryVC), animated: true, completion: nil)
    }
    
    @objc func handleAddCard(_ sender: UIButton) {
        let itemCategoryVC = ItemCategoryViewController(category: .Card)
        present(UINavigationController(rootViewController: itemCategoryVC), animated: true, completion: nil)
    }
}
//MARK:- UICollectionViewDelegate, UICollectionViewDataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reusableIdentifier, for: indexPath) as! CategoryCell
        if indexPath.row == 0 {
            cell.categoryLabel.text = Category.Brand.rawValue
            cell.category = .Brand
            cell.addItemButton.addTarget(self, action: #selector(handleAddBrand), for: .touchUpInside)
        }else if indexPath.row == 1  {
            cell.categoryLabel.text = Category.Card.rawValue
            cell.category = .Card
            cell.addItemButton.addTarget(self, action: #selector(handleAddCard), for: .touchUpInside)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
}
//MARK:- UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: self.view.frame.width, height: 280)
        }
        return CGSize(width: self.view.frame.width, height: 200)
    }
}

extension MainViewController: UNUserNotificationCenterDelegate {
    func localNotification(text: String){
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "IBM", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: text, arguments: nil)
        content.sound = UNNotificationSound.default()
        let request = UNNotificationRequest(identifier: "IBM", content: content, trigger: nil)
        center.add(request, withCompletionHandler: nil)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}
