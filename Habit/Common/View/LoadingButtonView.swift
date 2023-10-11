//
//  LoadingButtonView.swift
//  Habit
//
//  Created by user246507 on 10/1/23.
//

import SwiftUI

struct LoadingButtonView: View {
    var action: () -> Void
    var text: String
    var showProgress: Bool = false
    var disable: Bool = false
    
    var body: some View {
        ZStack {
            Button(action: {
                action()
            }, label: {
                Text(showProgress ? "" : text)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .font(Font.system(.title3).bold())
                    .background(disable ? Color("lightOrange") : Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(4)
            }).disabled(disable)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .opacity(showProgress ? 1 : 0)
                
        }
    }
}

struct LoadingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingButtonView(action: {
            print("clicou")
        }, text: "Entrar",
            showProgress: false,
            disable: false
        )
        .padding(.horizontal, 16)
    }
}
