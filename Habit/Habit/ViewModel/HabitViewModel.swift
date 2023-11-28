//
//  HabitViewModel.swift
//  Habit
//
//  Created by Adriano on 31/10/23.
//

import Foundation
import Combine
import SwiftUI

class HabitViewModel: ObservableObject {
    
    @Published var uiState: HabitIUState = .loading
    
    @Published var title: String = ""
    @Published var headline: String = ""
    @Published var description: String = ""
    
    @Published var opened = false
    
    private let interactor: HabitInteractor
    let isCharts: Bool
    
    private var cancellableRequest: AnyCancellable?
    private var cancellableNotify: AnyCancellable?
    
    
    private let habitPublisher = PassthroughSubject<Bool, Never>()
    
    init(isCharts: Bool, intercator: HabitInteractor) {
        self.isCharts = isCharts
        self.interactor = intercator
        cancellableNotify = habitPublisher.sink(receiveValue: { saved in
            print("saved: \(saved)")
            self.onAppear()
        })
    }
    
    deinit {
        cancellableRequest?.cancel()
        cancellableNotify?.cancel()
    }
    
    func onAppear() {
        self.opened = true
        self.uiState = .loading
        
        
        cancellableRequest = interactor.fetchHabits()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion) {
                    case .failure(let appError):
                        self.uiState = .error(appError.message)
                        break
                    case .finished:
                        break
                }
                
            }, receiveValue: { response in
                if response.isEmpty {
                    self.uiState = .emptyList
                    self.title = ""
                    self.headline = "Ops!"
                    self.description = "Você ainda não possui hábitos cadastrados!"
                }
                else {
                    self.uiState = .fullList(
                        response.map {
                            
                            //formato para exibição
                            let lastDate = $0.lastDate?.toDate(
                                sourcePattern: "yyyy-MM-dd'T'HH:mm:ss",
                                destPattern: "dd/MM/yyyy HH:mm") ?? ""
                            
                            var state: Color = .green
                            self.title = "Muito Bom!"
                            self.headline = "Seus hábitos Estão em dia!"
                            self.description = ""
                
                            //formato para comparação
                            let datetoCompare = $0.lastDate?.toDate(sourcePattern: "yyyy-MM-dd'T'HH:mm:ss") ?? Date()
                            
                            if datetoCompare < Date() {
                                state = .red
                                self.title = "Atenção!"
                                self.headline = "Fique Ligado!"
                                self.description = "Você está atrasado nos hábitos"
                            }
                            
                            return HabitCardViewModel(id: $0.id,
                                                      icon: $0.iconUrl ?? "",
                                                      date: lastDate,
                                                      name: $0.name,
                                                      label: $0.label,
                                                      value: "\($0.value ?? 0)",
                                                      state: state, habitPublisher: self.habitPublisher)
                        }
                    )

                }
                
            })
    }
}
