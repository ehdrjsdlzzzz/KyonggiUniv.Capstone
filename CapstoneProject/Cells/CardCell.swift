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
            self.cardNameLabel.text = card?.card_name
            self.cardCategoryLabel.text = card?.card_type
            self.cardCompanyLabel.text = card?.card_company
            
            if card?.card_type == "신용카드" {
                self.backgroundColor = UIColor.themeDeepBlueGreen
            }else if card?.card_type == "체크카드"{
                self.backgroundColor = UIColor.themeLightBlueGreen
            }else{
                self.backgroundColor = UIColor.themeOpaqueBlueGreen
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 15
    }
}
