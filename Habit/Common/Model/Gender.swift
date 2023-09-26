//
//  Gender.swift
//  Habit
//
//  Created by user246507 on 9/26/23.
//

import Foundation

enum Gender: String, CaseIterable, Identifiable {
    case male = "Masculino"
    case female = "Feminino"
    
    var id: String {
        self.rawValue
    }
}
