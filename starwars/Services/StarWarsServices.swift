//
//  StarWarsServices.swift
//  starwars
//
//  Created by Gustavo Cortez on 31/10/2020.
//

import Foundation

class StarWarsServices {
    static let shared = StarWarsServices()
    let URL_BASE = "https://swapi.dev/api"
    let CHARACTERS = "/people"
    let session = URLSession(configuration: .default)
    
    func getCharacters(onSuccess: @escaping (Characters) -> Void, onError: @escaping (String) -> Void) {
        let url = URL(string: "\(URL_BASE)\(CHARACTERS)")!
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        let results = try JSONDecoder().decode(Characters.self, from: data)
                        onSuccess(results)
                    } else {
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        onError(err.message)
                    }
                }
                catch {
                    onError(error.localizedDescription)
                }
            }
            
        }
        task.resume()
    }
    
    func getWorld(url: String, onSuccess: @escaping (World) -> Void, onError: @escaping (String) -> Void) {
        
        let worldUrl = URL(string: url)!
        let task = session.dataTask(with: worldUrl) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        let results = try JSONDecoder().decode(World.self, from: data)
                        onSuccess(results)
                    } else {
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        onError(err.message)
                    }
                }
                catch {
                    onError(error.localizedDescription)
                }
            }
            
        }
        task.resume()
    }
}
