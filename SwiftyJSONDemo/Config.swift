//
//  Config.swift
//  SwiftyJSONDemo
//
//  Created by Ben Smith on 09/03/2018.
//  Copyright © 2018 Ben Smith. All rights reserved.
//


import Foundation

class Config {
    static let shared = Config()

    fileprivate var dict: [String: String]!

    init() {
        if let url = Bundle.main.url(forResource: "Config", withExtension: "json") {
            if let data = try? Data(contentsOf: url) {
                if let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
                    self.dict = dict
                    return
                }
            }

        }
        NSException(name: NSExceptionName(rawValue: "Missing Config.json for environment"), reason: "Cannot parse Config.json file", userInfo: nil).raise()
    }

    func getStr(_ key: String) -> String {
        if let str = dict[key] {
            return str
        }
        NSException(name: NSExceptionName(rawValue: "Config key not found"), reason: "Key \(key) nor found in config file", userInfo: nil).raise()
        return ""
    }
    var showDusitGold: Bool {
        return getStr("ShowDusitGold")=="1"
    }
}
