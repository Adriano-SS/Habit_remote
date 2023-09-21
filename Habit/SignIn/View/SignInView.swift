//
//  SignInView.swift
//  Habit
//
//  Created by user246507 on 9/20/23.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel: SignInViewModel
    
    var body: some View {
        Text("SignInView ou Tela de Login")
            .background(Color.red)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SignInViewModel()
        SignInView(viewModel: viewModel)
    }
}
