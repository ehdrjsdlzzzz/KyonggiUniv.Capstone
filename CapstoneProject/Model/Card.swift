//
//  Card.swift
//  CapstoneProject
//
//  Created by 이동건 on 2018. 4. 19..
//  Copyright © 2018년 이동건. All rights reserved.
//

import Foundation

struct Card: Codable{
    static let key = "Seleceted.Cards"
    static let identifier = "Cell.Card"
    var card_type: String
    var card_company: String
    var card_name: String
}
