//
//  APIManager.swift
//  SwiftyJSONDemo
//
//  Created by Ben Smith on 09/03/2018.
//  Copyright © 2018 Ben Smith. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class APIResponse {
    var json:Data;
    var errorMessage:String?;
    init(json:Data) {
        self.json = json
    }
}

class APIManager {
    static let shared = APIManager()
    let url: URL = URL(string: Config.shared.getStr("ApiBase"))!
    
    private init() {
        print("Initializing APIEngine with base url: \(url)")
    }
    
    func getSpecialOffers(success:@escaping (([Offer], Data) -> Void), failure:@escaping ((String) -> Void)) {
        Alamofire.request("https://app-dev.dusit.com/api/v1/offers",
            method: .get,
            parameters: nil,
            encoding: JSONEncoding.default).responseData { (response) in
                response.result.ifSuccess({
                    if let jsonData = response.data {
                        let res = APIResponse(json: jsonData)
                        
                        print("success \(res)")
                        let decoder = JSONDecoder()
                        do {
                            let offers = try decoder.decode([Offer].self, from: res.json)
                            print(offers)
                            return success(offers, res.json)
                        } catch {
                            print("Unexpected error: JSON parsing error")
                            return failure(res.errorMessage ?? "Unexpected error: Unknown error")
                        }
                        
                    } else {
                        failure("Unexpected error: Error parsing response")
                    }
                })
                response.result.ifFailure({
                    failure("Failed")

                })
        }
    }
}
