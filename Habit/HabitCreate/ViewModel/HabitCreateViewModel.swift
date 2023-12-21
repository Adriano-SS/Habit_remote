//
//  HabitCreateViewModel.swift
//  Habit
//
//  Created by Adriano on 21/12/23.
//

import Foundation
import SwiftUI
import Combine

class HabitCreateViewModel: ObservableObject {
    
    @Published var uiState: HabitDetailUIState = .none
    @Published var name: String = ""
    @Published var label: String = ""
    
    private var cancellable: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    var habitPublisher: PassthroughSubject<Bool, Never>?
    
   
    let interactor: HabitDetailInteractor
    
    init(interactor: HabitDetailInteractor) {
        
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
    
    func save() {
        self.uiState = .loading
        
    }
}
