//
//  HabitViewModel.swift
//  Habit
//
//  Created by Adriano on 31/10/23.
//

import Foundation

class HabitViewModel: ObservableObject {
    
    @Published var uiState: HabitIUState = .loading
    @Published var title: String = "Atenção"
    @Published var headline: String = "Fique ligado"
    @Published var description: String = "Você está atrasado"
    
    func onAppear() {
        self.uiState = .emptyList
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
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
        }
    }
}
