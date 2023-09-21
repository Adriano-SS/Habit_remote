//
//  SignUpView.swift
//  Habit
//
//  Created by user246507 on 9/20/23.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel
    
    var body: some View {
        Text("SigUpView ou Tela de Cadastro")
            .background(Color.green)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SignUpViewModel()
        SignUpView(viewModel: viewModel)
    }
}
