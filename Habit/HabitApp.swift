//
//  HabitApp.swift
//  Habit
//
//  Created by user246507 on 9/16/23.
//

import SwiftUI

@main
struct HabitApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: SplashViewModel())
        }
    }
}
