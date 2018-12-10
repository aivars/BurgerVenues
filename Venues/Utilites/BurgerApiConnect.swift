//
//  BurgerApiConnect.swift
//  Venues
//
//  Created by Aivars Meijers on 08/12/2018.
//  Copyright © 2018 Aivars Meijers. All rights reserved.
//

import Foundation

struct Urls: Codable {
    let urls: [String]
}

struct Result: Codable {
    let urlWithBurger: String?
    let error: String?
}
struct BurgerApiConnect {
    
    func verifyUrls (imageUrls: [String], completionHandler: @escaping (String) -> ()) {
        let staticApiUrl = "https://pplkdijj76.execute-api.eu-west-1.amazonaws.com/prod/recognize"
        guard let apiUrl = URL(string:  staticApiUrl) else {
            completionHandler ("error")
            return
        }
        
        let urls = Urls(urls: imageUrls)
        print(imageUrls)
        print(urls)
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        
        do {
            let jsonData = try JSONEncoder().encode(urls)
            request.httpBody = jsonData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let session = URLSession.shared
            session.dataTask(with: request) { data, _, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let data = data else {
                    completionHandler ("error")
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Result.self, from: data)
                    if result.urlWithBurger != nil {
                        guard let burgerUrl = result.urlWithBurger else {
                            completionHandler("error")
                            return
                        }
                        completionHandler(burgerUrl)
                    }
                } catch {
                    print(error)
                    completionHandler ("error")
                }
                
                }.resume()
        } catch {
            print("Can't encode JSON")
            completionHandler ("error")
        }
    }
}



