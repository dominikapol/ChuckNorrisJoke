//
//  Category.swift
//  ChuckNorrisJokes
//
//  Created by Vladislav on 4.10.21.
//

import Foundation

struct Joke: Codable {
    let iconURL: String
    let value: String
    
    enum CodingKeys: String, CodingKey {
        case iconURL = "icon_url"
        case value
    }
}
