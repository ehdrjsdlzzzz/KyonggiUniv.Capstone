//
//  UserDefaults + data.swift
//  CapstoneProject
//
//  Created by 이동건 on 2018. 5. 31..
//  Copyright © 2018년 이동건. All rights reserved.
//

import Foundation

extension UserDefaults {
    func loadCards()->[Card]{
        var cards:[Card] = []
        if let data = UserDefaults.standard.object(forKey: Card.key) as? Data {
            cards = try! PropertyListDecoder().decode([Card].self, from: data) // --- 2
        }
        return cards
    }
    
    func loadBrands()->[Brand] {
        var brands:[Brand] = []
        if let data = UserDefaults.standard.object(forKey: Brand.key) as? Data {
            brands = try! PropertyListDecoder().decode([Brand].self, from: data) // --- 2
        }
        return brands
    }
}
