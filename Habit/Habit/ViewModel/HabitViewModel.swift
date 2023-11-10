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
    
    @Published var uiState: HabitIUState = .emptyList
    @Published var title: String = ""
    @Published var headline: String = ""
    @Published var description: String = ""
    @Published var opened = false
    
    private let interactor: HabitInteractor
    private var cancellableRequest: AnyCancellable?
    
    init(intercator: HabitInteractor) {
        self.interactor = intercator
    }
    
    deinit {
        cancellableRequest?.cancel()
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
                            /*let lastDateCompare = $0.lastDate?.toDate(
                                sourcePattern: "yyyy-MM-dd'T'HH:mm:ss",
                                destPattern: "yyyy-MM-dd HH:mm") ?? ""*/
                            
                            let datetoCompare = $0.lastDate?.toDate(sourcePattern: "yyyy-MM-dd'T'HH:mm:ss") ?? Date()
                            if datetoCompare < Date() {
                                state = .red
                                self.title = "Atenção!"
                                self.headline = "Fique Ligado!"
                                self.description = "Você está atrasado nos hábitos"
                            }
                            /*if lastDateCompare < Date().toString(
                                destPattern: "yyyy-MM-dd HH:mm") {
                                state = .red
                                self.title = "Atenção!"
                                self.headline = "Fique Ligado!"
                                self.description = "Você está atrasado nos hábitos"
                            }*/
                            return HabitCardViewModel(id: $0.id,
                                                      icon: $0.iconUrl ?? "",
                                                      date: lastDate,
                                                      name: $0.name,
                                                      label: $0.label,
                                                      value: "\($0.value ?? "0")",
                                                      state: state)
                        }
                    )

                }
                
            })
        
        /*DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            var rows: [HabitCardViewModel] = []
            
            rows.append(HabitCardViewModel(id: 1,
                                           icon: "https://placehold.co/150x150/png",
                                           date: "01/11/2023 09:44:00",
                                           name: "Estudar Swift",
                                           label: "horas",
                                           value: "2",
                                           state: .green))
            
            rows.append(HabitCardViewModel(id: 2,
                                           icon: "https://placehold.co/150x150/png",
                                           date: "01/11/2023 09:44:00",
                                           name: "Estudar Swift",
                                           label: "horas",
                                           value: "2",
                                           state: .green))
            
            rows.append(HabitCardViewModel(id: 3,
                                           icon: "https://placehold.co/150x150/png",
                                           date: "01/11/2023 09:44:00",
                                           name: "Estudar Swift",
                                           label: "horas",
                                           value: "2",
                                           state: .green))
            
            rows.append(HabitCardViewModel(id: 4,
                                           icon: "https://placehold.co/150x150/png",
                                           date: "01/11/2023 09:44:00",
                                           name: "Estudar Swift",
                                           label: "horas",
                                           value: "2",
                                           state: .green))
            self.uiState = .fullList(rows)
            //self.uiState = .error("Falha Interna no Servidor")
        }*/
    }
}
