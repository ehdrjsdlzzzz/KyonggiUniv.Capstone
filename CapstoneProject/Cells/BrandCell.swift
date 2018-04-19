//
//  BrandCell.swift
//  CapstoneProject
//
//  Created by 이동건 on 2018. 4. 19..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class BrandCell: UICollectionViewCell {
    
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var brandLogoImage: UIImageView!
    var brand: Brand? {
        didSet{
            brandLogoImage.image = brand?.image
            brandNameLabel.text = brand?.name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func prepareForReuse() {
        brandNameLabel.text = nil
        brandLogoImage.image = nil
    }
}
