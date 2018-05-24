//
//  CategoryCell.swift
//  CapstoneProject
//
//  Created by 이동건 on 2018. 4. 19..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    //MARK: Outlets
    @IBOutlet weak var itemsCollectionView: UICollectionView! {
        didSet{
            itemsCollectionView.backgroundColor = UIColor.themeDarkBlue
        }
    }
    @IBOutlet weak var categoryLabel: UILabel! {
        didSet{
            categoryLabel.textColor = UIColor.themeLightSkin
        }
    }
    @IBOutlet weak var addItemButton: UIButton!
    //MARK: Properties
    var category:Category = .Card {
        didSet{
            self.itemsCollectionView.reloadData()
        }
    }
    //MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.themeDarkBlue
        setupCollectioView()
        setupGesture()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    //MARK: Setup collectionViews
    fileprivate func setupCollectioView(){
        itemsCollectionView.delegate = self
        itemsCollectionView.dataSource = self
        
        itemsCollectionView.register(UINib(nibName: BrandCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: BrandCell.reusableIdentifier)
        itemsCollectionView.register(UINib(nibName: CardCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: CardCell.reusableIdentifier)
        itemsCollectionView.showsHorizontalScrollIndicator = false
    }
}
//MARK:- UICollectionViewDelegate, UICollectionViewDataSource
extension CategoryCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch category {
        case .Card:
            return UserData.default.cards.count
        case .Brand:
            return UserData.default.brands.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch category {
        case .Brand:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandCell.reusableIdentifier, for: indexPath) as! BrandCell
            cell.brand = UserData.default.brands[indexPath.row]
            return cell
        case .Card:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.reusableIdentifier, for: indexPath) as! CardCell
            cell.card = UserData.default.cards[indexPath.row]
            cell.layer.cornerRadius = 15
            cell.layer.masksToBounds = true
            return cell
        }
    }
}
//MARK:- UICollectionViewDelegateFlowLayout
extension CategoryCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch category {
        case .Card:
            return CGSize(width: 258, height: 162)
        case .Brand:
            return CGSize(width: 180, height: 250)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch category {
        case .Card:
            return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        case .Brand:
            return UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
}
