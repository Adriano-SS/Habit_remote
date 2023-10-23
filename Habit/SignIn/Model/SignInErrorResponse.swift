//
//  SignInErrorResponse.swift
//  Habit
//
//  Created by Adriano on 20/10/23.
//

import Foundation

struct SignInErrorResponse: Decodable {
    let detail: SignInDetailErrorResponse
    
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}

struct SignInDetailErrorResponse: Decodable {
    let message: String
    
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}
