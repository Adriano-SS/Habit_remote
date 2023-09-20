//
//  SplashViewModel.swift
//  Habit
//
//  Created by user246507 on 9/20/23.
//

import Foundation
class SplashViewModel: ObservableObject {
    @Published var uiState: SplashUIState = .loading
    
    func onApperar(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.uiState = .error("Perda de conexao com o servidor")
        }
    }
}