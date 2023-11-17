//
//  HabitDetailView.swift
//  Habit
//
//  Created by Adriano on 13/11/23.
//

import SwiftUI

struct HabitDetailView: View {
    @ObservedObject var viewModel: HabitDetailViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(viewModel: HabitDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 12) {
                Text(viewModel.name)
                    .foregroundColor(Color.orange)
                    .font(.title.bold())
                
                Text("Unidade: \(viewModel.label)\n")
                    .font(.title3.bold())
            }
            VStack {
                TextField("Informe aqui o valor conquistado", text: $viewModel.value)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                    .keyboardType(.numberPad)
                
                Divider()
                    .frame(height: 1)
                    .background(Color.green)
            }.padding(.horizontal, 32)
            
            Text("Os registros devem ser feitos em até 24 horas.\nHábitos se constroem diariamente!")
            
            LoadingButtonView(action: {
                viewModel.save()
            },
            text: "Salvar",
            showProgress: self.viewModel.uiState == .loading,
            disable: self.viewModel.value.isEmpty)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            
            Button("Cancelar") {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
                    withAnimation(.easeOut(duration: 2)) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                
            }
            .modifier(ButtonStyle())
            .padding(.horizontal, 16)
            
            Spacer()
        
        }
        .padding(.horizontal, 8)
        .padding(.top, 32)
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            HabitDetailView(viewModel: HabitDetailViewModel(id: 0, name: "Teste", label: "Dias", interactor: HabitDetailInteractor()))
                .previewDevice("Iphone 11")
                .preferredColorScheme($0)
        }
    }
}
