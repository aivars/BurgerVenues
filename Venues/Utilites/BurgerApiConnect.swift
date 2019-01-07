//
//  BurgerApiConnect.swift
//  Venues
//
//  Created by Aivars Meijers on 08/12/2018.
//  Copyright © 2018 Aivars Meijers. All rights reserved.
//

import Foundation
import os.log

struct Urls: Codable {
    let urls: [String]
}

struct BurgerResult: Codable {
    let urlWithBurger: String?
    let error: String?
}

enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
}

typealias Handler = (Result<String, NSError>) -> Void

struct BurgerApiConnect {
    
    func verifyUrls (imageUrls: [String], completionHandler: @escaping (String) -> ()) {
        guard let apiUrl = URL(string:  Constants.Urls.burgerApiUrl) else {return}
        let urls = Urls(urls: imageUrls)
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        do {
            let jsonData = try JSONEncoder().encode(urls)
            request.httpBody = jsonData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let session = URLSession.shared
            session.dataTask(with: request) { data, _, error in
                if let error = error {
                    os_log("error: %s", log: Log.general, type: .error, error as CVarArg)
                    return
                }
                guard let data = data else {
                    completionHandler ("error")
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(BurgerResult.self, from: data)
                        guard let burgerUrl = result.urlWithBurger else {
                            completionHandler("error")
                            return
                        }
                        completionHandler(burgerUrl)
                } catch {
                    os_log("error: %s", log: Log.general, type: .error, error as CVarArg)
                    completionHandler ("error")
                }
                
                }.resume()
        } catch {
            os_log("Can't encode JSON", log: Log.general, type: .error)
            completionHandler ("error")
        }
    }
}



