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
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addItemButton: UIButton!
    //MARK: Properties
    var brands:[Brand]?
    var cards:[Card]?
    //MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectioView()
        setupGesture()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        brands = nil
        cards = nil
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
        if let brands = self.brands {
            return brands.count
        }else if let cards = self.cards {
            return cards.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let brands = self.brands {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandCell.reusableIdentifier, for: indexPath) as! BrandCell
            cell.brand = brands[indexPath.row]
            return cell
        }else if let cards = self.cards {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.reusableIdentifier, for: indexPath) as! CardCell
            cell.card = cards[indexPath.row]
            cell.layer.cornerRadius = 15
            cell.layer.masksToBounds = true
            return cell
        }
        return UICollectionViewCell()
    }
}
//MARK:- UICollectionViewDelegateFlowLayout
extension CategoryCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let _ = self.brands {
            return CGSize(width: 180, height: 250)
        }else if let _ = self.cards {
            return CGSize(width: 258, height: 162)
        }
        
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if let cards = self.cards {
            return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        }
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
}
