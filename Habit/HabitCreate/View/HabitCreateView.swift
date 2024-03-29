//
//  HabitCreatView.swift
//  Habit
//
//  Created by Adriano on 21/12/23.
//

import SwiftUI
import PhotosUI

struct HabitCreateView: View {
    @ObservedObject var viewModel: HabitCreateViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var shouldPresentedCamera: Bool = false
    
    init(viewModel: HabitCreateViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center) {
                
                Text("Cadastro de Novo Hábito:")
                    .font(.title.bold())
                    .padding(.bottom, 20)
                
                Button(action: {
                    shouldPresentedCamera = true
                    //code
                    
                }, label: {
                    viewModel.image!
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.orange)
                })
                
                PhotosPicker(selection: $viewModel.imageSelection, matching: .images) {
                    Text("Abrir galeria")
                        .foregroundColor(.red)
                        .padding(.bottom, 12)
                }
                
                //Text("Clique aqui para enviar")
                    //.padding(.bottom, 12)

            }
            VStack {
                TextField("Informe o nome do hábito", text: $viewModel.name)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                    
                Divider()
                    .frame(height: 1)
                    .background(Color.orange)
                    .padding(.bottom, 12)
                
                TextField("Informe o tipo de medida do hábito", text: $viewModel.label)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                
                Divider()
                    .frame(height: 1)
                    .background(Color.orange)
                    .padding(.bottom, 12)
                
            }.padding(.horizontal, 32)
        
            LoadingButtonView(action: {
                viewModel.save()
            },
            text: "Salvar",
            showProgress: self.viewModel.uiState == .loading,
            disable: self.viewModel.name.isEmpty || self.viewModel.label.isEmpty)
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

struct HabitCreateView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            HabitCreateView(viewModel: HabitCreateViewModel(interactor: HabitCreateInteractor()))
                .previewDevice("Iphone 11")
                .preferredColorScheme($0)
        }
    }
}

