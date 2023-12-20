//
//  ChartView.swift
//  Habit
//
//  Created by Adriano on 28/11/23.
//

import SwiftUI
import Charts

struct ChartView: View {
    //para o picker
    enum TypeChart: String, CaseIterable, Identifiable {
        case line = "Linha"
        case bar = "Barra"
        
        var id: Self { return self }
    }
    
    @State private var selectedTypeChart = TypeChart.line
    
    @ObservedObject var viewModel: ChartViewModel
    
    var body: some View {
        ZStack {
            if case ChartUIState.loading = viewModel.uiState {
                ProgressView()
            }
            else {
                VStack {
                    if case ChartUIState.emptyChart = viewModel.uiState {
                        Image(systemName: "exclamationmark.bubble")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24, alignment: .center)
                        
                        Text("Nenhum Hábito Cadastrado :(")
                    }
                    else if case ChartUIState.error(let msg) = viewModel.uiState {
                        Text("")
                            .alert(isPresented: .constant(true)) {
                                Alert(
                                    title: Text("Ops! \(msg)"),
                                    message: Text("Tentar novamente?"),
                                    primaryButton: .default(Text("Sim")) {
                                        //executa outra tentativa
                                        viewModel.onAppear()
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                    }
                    else {
                        VStack {
                            Picker(selection: $selectedTypeChart.animation()) {
                                ForEach(TypeChart.allCases) {
                                    type in
                                    Text(type.rawValue)
                                }
                            } label: {
                                Text("Choose your chart type:")
                            }
                            .pickerStyle(.segmented)
                            Spacer()
                            Group {
                                switch selectedTypeChart {
                                    case .line:
                                        LineChartView(entries: $viewModel.entries)
                                    case .bar:
                                        BarChartView(entries: $viewModel.entries)
                                }
                            }
                            .aspectRatio(1, contentMode: .fit)
                            
                            Spacer()
                            
                        }
                        .padding()
                    }
                }
                
            }
        }
        .onAppear(perform: viewModel.onAppear)
    }
}

class DateAxisValueFormatter {
    
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        HabitCardViewRouter.makeChartView(id: 1)
    }
}
