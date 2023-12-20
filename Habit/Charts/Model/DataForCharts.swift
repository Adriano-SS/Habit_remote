//
//  DataForCharts.swift
//  Habit
//
//  Created by Adriano on 07/12/23.
//

import Foundation

struct DataForCharts: Identifiable {
    var id = UUID().uuidString
    var day: String
    var value: Int
}
