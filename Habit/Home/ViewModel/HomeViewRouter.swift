//
//  HomeViewRouter.swift
//  Habit
//
//  Created by Adriano on 31/10/23.
//

import Foundation
import SwiftUI

enum HomeViewRouter {
    static func makeHabitView () -> some View {
        let viewModel = HabitViewModel()
        return HabitView(viewModel: viewModel)
    }
}
