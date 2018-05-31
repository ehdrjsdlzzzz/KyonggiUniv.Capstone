//
//  UserData.swift
//  CapstoneProject
//
//  Created by 이동건 on 2018. 5. 24..
//  Copyright © 2018년 이동건. All rights reserved.
//

import Foundation

class UserData {
    var cards:[Card] = []
    var brands:[Brand] = []

    static let `default` = UserData()
    private init(){}
    
}

struct CardSelectData {
    var card_type:String?
    var card_company:String?
    static var main = CardSelectData()
    private init(){}
    
}

extension UserDefaults {
    
}
