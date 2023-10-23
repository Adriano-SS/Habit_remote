//
//  SignUpRequest.swift
//  Habit
//
//  Created by Adriano on 10/10/23.
//

import Foundation

struct SignUpRequest: Encodable {
    let fullname: String
    let email: String
    let document: String
    let phone: String
    let gender: Int
    let birthday: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case fullname = "name"
        case email
        case document
        case phone
        case gender
        case birthday
        case password
    }
}
