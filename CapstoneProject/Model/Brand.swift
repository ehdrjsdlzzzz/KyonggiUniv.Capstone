//
//  Brand.swift
//  CapstoneProject
//
//  Created by 이동건 on 2018. 4. 19..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

struct Brand: Codable {
    static let key = "Seleceted.Brands"
    static let identifier = "Cell.Brand"
    var store_name:String
    var store_beacon_uuid:String
    var store_beacon_minor:Int
    var store_beacon_major:Int
    var store_img: String?
}
