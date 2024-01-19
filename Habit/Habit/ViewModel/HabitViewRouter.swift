//
//  HabitViewRouter.swift
//  Habit
//
//  Created by Adriano on 21/12/23.
//

import Foundation
import SwiftUI
import Combine

enum HabitViewRouter {
    
    static func makeHabitCreatelView(
        habitPublisher: PassthroughSubject<Bool,Never>) -> some View {
            let viewModel = HabitCreateViewModel(interactor: HabitCreateInteractor())
            viewModel.habitPublisher = habitPublisher
            return HabitCreateView(viewModel: viewModel)
        }
}
