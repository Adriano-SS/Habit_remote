//
//  HomeViewModel.swift
//  Habit
//
//  Created by Adriano on 9/25/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
}

extension HomeViewModel {
    func habitView() -> some View {
        return HomeViewRouter.makeHabitView()
    }
}
