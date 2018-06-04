//
//  BrandCell.swift
//  CapstoneProject
//
//  Created by 이동건 on 2018. 4. 19..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class BrandCell: UICollectionViewCell {
    //MARK: Outlets
    @IBOutlet weak var brandNameLabel: UILabel! {
        didSet{
            brandNameLabel.textColor = UIColor.themeLightSkin
        }
    }
    @IBOutlet weak var brandLogoImage: UIImageView!
    //MARK: Properties
    var brand: Brand? {
        didSet{
            brandLogoImage.image = UIImage(named: (brand?.store_name.lowercased().replacingOccurrences(of: " ", with: "")) ?? "")
            brandNameLabel.text = brand?.store_name
        }
    }
    //MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func prepareForReuse() {
        brandNameLabel.text = nil
        brandLogoImage.image = nil
    }
}
