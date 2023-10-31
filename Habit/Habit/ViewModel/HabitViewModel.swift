//
//  HabitViewModel.swift
//  Habit
//
//  Created by Adriano on 31/10/23.
//

import Foundation

class HabitViewModel: ObservableObject {
    
    @Published var uiState: HabitIUState = .emptyList
    @Published var title: String = "Atenção"
    @Published var headline: String = "Fique ligado"
    @Published var description: String = "Você está atrasado"
}
