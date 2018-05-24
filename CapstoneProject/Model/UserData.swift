//
//  UserData.swift
//  CapstoneProject
//
//  Created by 이동건 on 2018. 5. 24..
//  Copyright © 2018년 이동건. All rights reserved.
//

import Foundation

class UserData {
    var cards:[Card] = [
        Card(category: "debit", name: "S20", company: "신한카드"),
        Card(category: "debit", name: "네이버페이 체크카드", company: "신한카드"),
        Card(category: "credit", name: "현대카드Zero", company: "현대카드"),
        Card(category: "credit", name: "삼성카드4", company: "삼성카드"),
        Card(category: "credit", name: "신한 Deep Dream", company: "신한카드"),
        Card(category: "credit", name: "청춘대로 톡톡카드", company: "KB국민")
    ]
    var brands:[Brand] = [
        Brand(image: #imageLiteral(resourceName: "starbucks"), name: "Starbucks"),
        Brand(image: #imageLiteral(resourceName: "lush"), name: "LUSH"),
        Brand(image: #imageLiteral(resourceName: "tomntoms"), name: "Tom N Toms"),
        Brand(image: #imageLiteral(resourceName: "nike"), name: "Nike"),
        Brand(image: #imageLiteral(resourceName: "newbalance"), name: "New Balance")
    ]

    static let `default` = UserData()
    private init(){}
    
}
