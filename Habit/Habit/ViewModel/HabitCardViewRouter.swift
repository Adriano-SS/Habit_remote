//
//  HabitDetailViewRouter.swift
//  Habit
//
//  Created by Adriano on 14/11/23.
//

import Foundation
import SwiftUI
import Combine

enum HabitCardViewRouter {
    
    static func makeHabitDetailView(id: Int,
                                    name: String,
                                    label: String,
                                    habitPublisher: PassthroughSubject<Bool,Never>) -> some View {
        let viewModel = HabitDetailViewModel(id: id, name: name, label: label, interactor: HabitDetailInteractor())
        viewModel.habitPublisher = habitPublisher
        return HabitDetailView(viewModel: viewModel)
    }
    
    static func makeChartView(id: Int) -> some View {
        return ChartView()
    }
    
}
