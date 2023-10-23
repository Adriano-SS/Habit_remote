//
//  ErrorResponse.swift
//  Habit
//
//  Created by Adriano on 18/10/23.
//

import Foundation

struct ErrorResponse: Decodable {
    let detail: String
    
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}
