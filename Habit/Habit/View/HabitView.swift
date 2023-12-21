//
//  HabitView.swift
//  Habit
//
//  Created by Adriano on 31/10/23.
//

import Foundation
import SwiftUI

struct HabitView: View {
    @ObservedObject var viewModel: HabitViewModel
    
    var body: some View {
        ZStack {
            if case HabitIUState.loading = viewModel.uiState {
                progress
            }
            else {
                NavigationView {
                    ScrollView(showsIndicators: false){
                        VStack(spacing: 12) {
                            
                            if !viewModel.isCharts {
                                topContainer
                                
                                addButton
                            }
                            
                            if case HabitIUState.emptyList = viewModel.uiState {
                                Spacer(minLength: 60)
                                VStack {
                                    Image(systemName: "exclamationmark.bubble")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24, alignment: .center)
                                    
                                    Text("Nenhum Hábito Cadastrado :(")
                                }
                            }
                            else if case HabitIUState.fullList(let rows) = viewModel.uiState {
                                LazyVStack {
                                    ForEach(rows) { row in
                                        HabitCardView(isChart: viewModel.isCharts, viewModel: row)
                                    }
                                }.padding(.horizontal, 12)
                            }
                            else if case HabitIUState.error(let msg) = viewModel.uiState {
                                Text("")
                                    .alert(isPresented: .constant(true)) {
                                        Alert(
                                            title: Text("Ops! \(msg)"),
                                            message: Text("Tentar novamente?"),
                                            primaryButton: .default(Text("Sim")) {
                                                viewModel.onAppear()
                                            },
                                            secondaryButton: .cancel()
                                        )
                                    }
                            }
                        }
                    }.navigationTitle("Meus Hábitos")
                }
            }
        }.onAppear {
            if !viewModel.opened {
                viewModel.onAppear()
            }
        }
        
    }
}

extension HabitView {
    var progress: some View {
        return ProgressView()
    }
}

extension HabitView {
    var topContainer: some View {
        VStack(alignment: .center, spacing: 12){
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            Text(viewModel.title)
                .font(Font.system(.title).bold())
                .foregroundColor(Color.orange)
            Text(viewModel.headline)
                .font(Font.system(.title3).bold())
                .foregroundColor(Color.orange)
            Text(viewModel.description)
                .font(Font.system(.subheadline))
                .foregroundColor(Color.orange)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .overlay(RoundedRectangle(cornerRadius: 6)
            .stroke(Color.gray, lineWidth: 2)
        )
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
}

extension HabitView {
    var addButton: some View {
        NavigationLink(destination: viewModel.habitCreateView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)){

            Label("Criar hábito", systemImage: "plus.app")
                .modifier(ButtonStyle())
        }
        .padding(.horizontal, 16)
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            HomeViewRouter.makeHabitView(viewModel: HabitViewModel(isCharts: false, intercator: HabitInteractor()))
                .previewDevice("Iphone 11")
                .preferredColorScheme($0)
        }
    }
}
