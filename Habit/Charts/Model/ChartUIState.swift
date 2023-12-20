//
//  ChartUIState.swift
//  Habit
//
//  Created by Adriano on 07/12/23.
//

import Foundation

enum ChartUIState: Equatable {
    case loading
    case emptyChart
    case fullChart
    case error(String)
}
