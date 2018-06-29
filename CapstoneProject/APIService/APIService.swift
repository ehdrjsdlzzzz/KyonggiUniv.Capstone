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
    //MARK: Request all brands
    func request<T: Decodable>(url: URL?, completion: @escaping (T)->()){
        guard let url = url else {return}
        Alamofire.request(url).responseJSON { (response) in
            guard let data = response.data else {return}
            
            do {
                guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {return}
                completion(decodedData)
            }
        }
    }
    //MARK: Request card types
    func requestCardType(completion: @escaping ([Card])->()){
        Alamofire.request("\(BASE_URL)/card/type", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            let result = response.result
            switch result {
            case .success:
//                guard let result = result.value as? [[String:String]] else {return}
//                var types:[String] = []
//                result.forEach({types.append($0["card_type"]!)})
//                completion(types)
                guard let data = response.data else {return}
                do {
                    guard let decodedData = try? JSONDecoder().decode([Card].self, from: data) else {return}
                    completion(decodedData)
                }
                
            case .failure:
                print("Fails")
            }
        }
    }
    //MARK: Request card company
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
    //MARK: Request card list with types and company
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
    //MARK: Called when detect registerd store
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
    //MARK: 매장과 거리가 가까워졌을 떄
    func didClosed(at store: String){
        let parameter:[String:Any] = [
            "store_name" : store,
            "user": [
                "sex": "M",
                "age" : 25
            ]
        ]
        
        Alamofire.request("\(BASE_URL)/store/connected", method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            let result = response.result
            switch result {
            case .success:
                print("Success")
            case .failure:
                print("Fails")
            }
        }
    }
}
