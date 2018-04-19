//
//  Beacon.swift
//  CapstoneProject
//
//  Created by 이동건 on 2018. 4. 19..
//  Copyright © 2018년 이동건. All rights reserved.
//

import Foundation

struct Beacon {
    var identifier:String
    var uuid:String
    var major:UInt16
    var minor:UInt16
    var description:String?
}

var beacons:[Beacon] = [
    Beacon(identifier: "00899", uuid: "74278BDA-B644-4520-8F0C-720EAF059935", major: 10001, minor: 19641, description: nil),
    Beacon(identifier: "00882", uuid: "74278BDA-B644-4520-8F0C-720EAF059936", major: 10001, minor: 19641, description: nil),
    Beacon(identifier: "00884", uuid: "74278BDA-B644-4520-8F0C-720EAF059937", major: 10001, minor: 19641, description: nil)
]
