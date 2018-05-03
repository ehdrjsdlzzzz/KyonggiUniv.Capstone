//
//  CardCell.swift
//  CapstoneProject
//
//  Created by 이동건 on 2018. 4. 19..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {

    @IBOutlet weak var cardCategoryLabel: UILabel! {
        didSet{
            cardCategoryLabel.textColor = UIColor.themeLightSkin
        }
    }
    @IBOutlet weak var cardNameLabel: UILabel! {
        didSet{
            cardNameLabel.textColor = UIColor.themeLightSkin
        }
    }
    @IBOutlet weak var cardCompanyLabel: UILabel! {
        didSet{
            cardCompanyLabel.textColor = UIColor.themeLightSkin
        }
    }
    
    var card:Card? {
        didSet {
            self.cardNameLabel.text = card?.name
            self.cardCategoryLabel.text = card?.category
            self.cardCompanyLabel.text = card?.company
            
            if card?.category == "credit" {
                self.backgroundColor = UIColor.themeDeepBlueGreen
            }else{
                self.backgroundColor = UIColor.themeLightBlueGreen
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
