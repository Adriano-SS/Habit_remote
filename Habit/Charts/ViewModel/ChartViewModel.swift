//
//  ChartViewModel.swift
//  Habit
//
//  Created by Adriano on 07/12/23.
//

import Foundation
import SwiftUI
import Charts
import Combine

class ChartViewModel: ObservableObject {
    
    @Published var uiState: ChartUIState = .loading
    
    private let habitId: Int
    private let interactor: ChartInteractor
    
    private var cancellable: AnyCancellable?
    
    init(habitId: Int, interactor: ChartInteractor) {
        self.habitId = habitId
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    @Published var entries: [DataForCharts] = []
    
    
    func onAppear() {
        cancellable = interactor.fetchHabitValues(habitId: habitId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion) {
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                case .finished:
                    break
                }
            }, receiveValue: { res in
                if res.isEmpty {
                    self.uiState = .emptyChart
                }
                else {
                    //extração das datas do HabitValue, para String formatada, e do value
                    self.entries = res.map {
                        DataForCharts(day: $0.createdDate.toDate(
                            sourcePattern: "yyyy-MM-dd'T'HH:mm:ss",
                            destPattern: "dd/MM") ?? "", value: $0.value)
                        
                    }
                    self.uiState = .fullChart
                }
                
            })
        
    }
}



