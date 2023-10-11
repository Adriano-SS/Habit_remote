//
//  SignUpRequest.swift
//  Habit
//
//  Created by user246507 on 10/10/23.
//

import Foundation

struct SignUpRequest: Encodable {
    let fullname: String
    let email: String
    let password: String
    let document: String
    let phone: String
    let birthday: String
    let gender: Int
    
    enum CodingKeys: String, CodingKey {
        case fullname = "name"
        case email
        case password
        case document
        case phone
        case birthday
        case gender
    }
}
