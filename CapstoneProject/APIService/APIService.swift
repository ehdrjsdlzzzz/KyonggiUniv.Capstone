//
//  APIService.swift
//  CapstoneProject
//
//  Created by 이동건 on 2018. 5. 31..
//  Copyright © 2018년 이동건. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    static let shared = APIService()
    private let BASE_URL = "https://warm-plains-89822.herokuapp.com"
    private init(){}
    
    func requestStore(completion: @escaping ([Brand])->()){
        Alamofire.request("\(BASE_URL)/store/all", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            let result = response.result
            switch result {
            case .success:
                guard let result = result.value as? [[String:Any]] else {return}
                guard let jsonData = try? JSONSerialization.data(withJSONObject: result, options: []) else {return}
                guard let brands = try? JSONDecoder().decode([Brand].self, from: jsonData) else {return}
                completion(brands)
            case .failure:
                print("Fails")
            }
        }
    }
    
    func requestCardType(completion: @escaping ([String])->()){
        Alamofire.request("\(BASE_URL)/card/type", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            let result = response.result
            switch result {
            case .success:
                guard let result = result.value as? [[String:String]] else {return}
                var types:[String] = []
                result.forEach({types.append($0["card_type"]!)})
                completion(types)
            case .failure:
                print("Fails")
            }
        }
    }
    
    func requestCardCompany(type: String, completion: @escaping ([String])->()){
        let parameters = [
            "card_type": type
        ]
        Alamofire.request("\(BASE_URL)/card/company", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            let result = response.result
            switch result {
            case .success:
                guard let result = result.value as? [[String:String]] else {return}
                var companies:[String] = []
                result.forEach({companies.append($0["card_company"]!)})
                completion(companies)
            case .failure:
                print("Fails")
            }
        }
    }
    
    func requestCardList(type: String, company: String, completion: @escaping ([String])->()){
        let parameters = [
            "card_type": type,
            "card_company": company
        ]
        
        Alamofire.request("\(BASE_URL)/card/name", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            let result = response.result
            switch result {
            case .success:
                guard let result = result.value as? [[String:String]] else {return}
                var cards:[String] = []
                result.forEach({cards.append($0["card_name"]!)})
                completion(cards)
            case .failure:
                print("Fails")
            }
        }
    }
    
    func didConnected(store: String, cards: [Card], completion: @escaping ([Promotion])->()){
        var companies:[String] = []
        cards.forEach({companies.append($0.card_company)})
        companies = Array(Set(companies))
        let parameters:[String: Any] = [
            "store_name": store,
            "cards": companies
        ]
        Alamofire.request("\(BASE_URL)/store/beacon/connected", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            let result = response.result
            switch result {
            case .success:
                guard let result = result.value as? [[[String:Any]]] else {return}
                guard let jsonData = try? JSONSerialization.data(withJSONObject: result[1], options: []) else {return}
                do {
                    guard let promotions = try? JSONDecoder().decode([Promotion].self, from: jsonData) else {print("Fail to decode");return}
                    completion(promotions)
                }
             case .failure:
                print("Fails")
            }
        }
    }
}
