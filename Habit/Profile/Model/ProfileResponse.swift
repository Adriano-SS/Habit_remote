//
//  ProfileResponse.swift
//  Habit
//
//  Created by Adriano on 27/11/23.
//

import Foundation

struct ProfileResponse: Decodable {
    let id: Int
    let fullname: String
    let email: String
    let document: String
    let phone: String
    let gender: Int
    let birthday: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullname = "name"
        case email
        case document
        case phone
        case gender
        case birthday
    }
}
