//
//  RefreshRequest.swift
//  Habit
//
//  Created by Adriano on 30/10/23.
//

import Foundation

struct RefreshRequest: Encodable {
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "refresh_token"
        
    }
}
