//
//  HabitDetailViewRouter.swift
//  Habit
//
//  Created by Adriano on 14/11/23.
//

import Foundation
import SwiftUI

enum HabitCardViewRouter {
    
    static func makeHabitDetailView(id: Int, name: String, label: String) -> some View {
        let viewModel = HabitDetailViewModel(id: id, name: name, label: label, interactor: HabitDetailInteractor())
        return HabitDetailView(viewModel: viewModel)
    }
    
}
