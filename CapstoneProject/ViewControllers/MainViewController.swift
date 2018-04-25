//
//  MainViewController.swift
//  CapstoneProject
//
//  Created by 이동건 on 2018. 4. 12..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    //MARK: Outlets
    var favoritesCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.themeWhite
        return collectionView
    }()
    var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Swagger", size: 16)
        label.textColor = UIColor.themeDark
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var greetingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Swagger", size: 28)
        label.textColor = UIColor.themeDark
        label.text = "It is good day to buy"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: Properties
    var brands:[Brand] = [
        Brand(image: #imageLiteral(resourceName: "starbucks"), name: "Starbucks"),
        Brand(image: #imageLiteral(resourceName: "lush"), name: "LUSH"),
        Brand(image: #imageLiteral(resourceName: "tomntoms"), name: "Tom N Toms"),
        Brand(image: #imageLiteral(resourceName: "nike"), name: "Nike"),
        Brand(image: #imageLiteral(resourceName: "newbalance"), name: "New Balance")
        ]
    let cardSelectView = CardSelectView.initFromNib()
    var cardSelectViewBottomConstraint:NSLayoutConstraint?
    var isMaximize:Bool = false
    var locationManager:CLLocationManager = CLLocationManager()
    var beaconRegion:CLBeaconRegion!
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initializeLocationManager()
    }
    //MARK: Setup Views
    fileprivate func setupViews(){
        setupNavigationBar()
        setupFavoritesCollectionView()
        self.view.backgroundColor = UIColor.themeWhite
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
//        setupCardSelectView()
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
        self.navigationController?.navigationBar.barTintColor = UIColor.themeWhite
        self.navigationController?.navigationBar.tintColor = UIColor.themeDark
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "setting"), style: .plain, target: self, action: #selector(handleSetting))
    }
    fileprivate func setupCardSelectView(){
        self.view.addSubview(cardSelectView)
        cardSelectView.translatesAutoresizingMaskIntoConstraints = false
        cardSelectViewBottomConstraint = cardSelectView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 340)
        cardSelectViewBottomConstraint?.isActive = true
        cardSelectView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        cardSelectView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        cardSelectView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        cardSelectView.dismissButton.addTarget(self, action: #selector(minimizeCardSelectView), for: .touchUpInside)
    }
    //MARK: Handle Card Select View Sizing
    func maximizeCardSelectView() {
        isMaximize = true
        cardSelectViewBottomConstraint?.constant = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.cardSelectView.selectView.alpha = 1
            self.cardSelectView.cardMenuBtnView.alpha = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    @objc func minimizeCardSelectView() {
        isMaximize = false
        cardSelectViewBottomConstraint?.constant = 340
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.cardSelectView.selectView.alpha = 0
            self.cardSelectView.cardMenuBtnView.alpha = 1
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    @objc func handleSetting(){
        
    }
}
//MARK:- UICollectionViewDelegate, UICollectionViewDataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reusableIdentifier, for: indexPath) as! CategoryCell
        cell.backgroundColor = UIColor.themeLightGreen
        cell.categoryLabel.textColor = UIColor.themeWhite
        if indexPath.row == 0 {
            cell.categoryLabel.text = "Brand"
            cell.brands = self.brands
        }else if indexPath.row == 1  {
            cell.categoryLabel.text = "Cards"
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

