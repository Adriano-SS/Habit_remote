//
//  AppError.swift
//  Habit
//
//  Created by Adriano on 24/10/23.
//

import Foundation

enum AppError: Error {
    case response(message: String)
    
    public var message: String {
        switch self {
        case .response(let message):
            return message
        }
    }
}
