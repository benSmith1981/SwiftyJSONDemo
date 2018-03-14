//
//  Offer.swift
//  SwiftyJSONDemo
//
//  Created by Ben Smith on 09/03/2018.
//  Copyright © 2018 Ben Smith. All rights reserved.
//


import UIKit

struct Offer: Codable {

    var name: String?
    var description: String?
    var image: String?
    var rateCode: String?
    var hotels: [String]?
    var privileges: String?
}
