//
//  Fetch.swift
//  Betano
//
//  Created by Pantos, Thomas on 28/4/23.
//

import Foundation


func fetchSports1(completion: @escaping ([Sport]?, Error?) -> Void) {
    if let url = URL(string: "https://618d3aa7fe09aa001744060a.mockapi.io/api/sports") {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let error = NSError(domain: "Invalid HTTP response", code: 0, userInfo: nil)
                completion(nil, error)
                
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "No data received", code: 0, userInfo: nil)
                completion(nil, error)
                return
            }
 
            do {
                let decoder = JSONDecoder()
                let sports = try decoder.decode([Sport].self, from: data)
                completion(sports, nil)
            
                
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
