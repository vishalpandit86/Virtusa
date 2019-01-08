//
//  APIManager.swift
//  PlanetDemo
//
//  Created by Tripathi, Himani on 1/8/19.
//  Copyright © 2019 Tripathi, Himani. All rights reserved.
//

import Foundation

struct APIManager {
    enum JSONError: String, Error {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }
    
    static var baseUrl: String {
        return "https://swapi.co/api/planets"
    }

    static func getDeatils ( callback :  @escaping (_ responseObject : Planets, _ error : NSError?) -> Void ) {
            guard let requestUrl = URL(string: APIManager.baseUrl) else { return }
        
            let request = URLRequest(url: requestUrl)
            let task = URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                do {
                    guard let data = data else {
                        throw JSONError.NoData
                    }

                    let decoder = JSONDecoder()
                    if let planets = try? decoder.decode(Planets.self, from: data) {
                        callback(planets, nil)
                    }
                } catch let error as JSONError {
                    print(error.rawValue)
                } catch let error as NSError {
                    print(error.debugDescription)
                }
            }
            task.resume()
        }
}
