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
    var category:Category = .card {
        didSet{
            switch category {
            case .card:
                self.cards = UserDefaults.standard.loadCards()
            case .brand:
                self.brands = UserDefaults.standard.loadBrands()
            }
            self.itemsCollectionView.reloadData()
        }
    }
    
    var cards:[Card] = []
    var brands:[Brand] = []
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
        case .card:
            return cards.count
        case .brand:
            return brands.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch category {
        case .brand:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandCell.reusableIdentifier, for: indexPath) as! BrandCell
            cell.brand = brands[indexPath.row]
            return cell
        case .card:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.reusableIdentifier, for: indexPath) as! CardCell
            cell.card = cards[indexPath.row]
            return cell
        }
    }
}
//MARK:- UICollectionViewDelegateFlowLayout
extension CategoryCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch category {
        case .card:
            return CGSize(width: 258, height: 162)
        case .brand:
            return CGSize(width: 180, height: 250)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch category {
        case .card:
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        case .brand:
            return UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
}
