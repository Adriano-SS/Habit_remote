//
//  HabitCardView.swift
//  Habit
//
//  Created by Adriano on 01/11/23.
//

import SwiftUI
import Combine

struct HabitCardView: View {
    
    let isChart: Bool
    let viewModel: HabitCardViewModel
    @State private var action: Bool = false
    
    var body: some View {
        
        ZStack(alignment: .trailing) {
            if isChart {
                NavigationLink(
                    destination: viewModel.chartView(),
                    isActive: self.$action,
                    label: {
                        EmptyView()
                    }
                )
            } else {
                NavigationLink(
                    destination: viewModel.habitDetailView(),
                    isActive: self.$action,
                    label: {
                        EmptyView()
                    }
                )
            }
            
            
            Button(
                action: {
                    self.action = true
                }, label: {
                    HStack {
                        if viewModel.icon.isEmpty {
                            Image(systemName: "pencil")
                                .foregroundColor(.black)
                        }
                        else {
                            ImageView(url: viewModel.icon)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 32, height: 32)
                                .clipped()
                        }
                        
                        
                        HStack(alignment: .top) {
                            Spacer()
                            VStack(alignment: .leading, spacing: 4){
                                Text(viewModel.name)
                                    .foregroundColor(.orange)
                                    .bold()
                                Text(viewModel.label)
                                    .foregroundColor(Color("textColor"))
                                    .bold()
                                Text(viewModel.date)
                                    .foregroundColor(Color("textColor"))
                                    .bold()
                                
                            }
                            .frame(maxWidth: 300, alignment: .leading)
                            
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 4){
                                Text("Registrado")
                                    .foregroundColor(.orange)
                                    .bold()
                                    .multilineTextAlignment(.leading)
                                Text(viewModel.value)
                                    .foregroundColor(Color("textColor"))
                                    .bold()
                                    .multilineTextAlignment(.leading)
                            }
                            
                            Spacer()
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .cornerRadius(4)
                })
            if !isChart {
                Rectangle()
                    .frame(width: 8)
                    .foregroundColor(viewModel.state)
            }
            
        }
        .background(
        RoundedRectangle(cornerRadius: 4)
            .stroke(Color.orange, lineWidth: 1.4)
            .shadow(color: .gray, radius: 2, x: 2, y: 2)
        )
        .padding(.horizontal, 2)
        .padding(.vertical, 8)
    }
}

struct HabitCardView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            
            NavigationView {
                List {
                    HabitCardView(isChart: false, viewModel: HabitCardViewModel(
                        id: 1,
                        icon: "https://placehold.co/150x150/png",
                        date: "01/11/2023 09:44:00",
                        name: "Estudar Swift",
                        label: "horas",
                        value: "2",
                        state: .green,
                        habitPublisher: PassthroughSubject<Bool, Never>()))
                    
                    HabitCardView(isChart: true, viewModel: HabitCardViewModel(
                        id: 2,
                        icon: "https://placehold.co/150x150/png",
                        date: "12/06/2024 09:44:00",
                        name: "Plantar árvores",
                        label: "quantidade",
                        value: "5",
                        state: .green,
                        habitPublisher: PassthroughSubject<Bool, Never>()))
                }
                .frame(maxWidth: .infinity)
                .navigationTitle("Testando")
            }
            .previewDevice("Iphone 14")
            .preferredColorScheme($0)
            
            
        }
        
    }
}
