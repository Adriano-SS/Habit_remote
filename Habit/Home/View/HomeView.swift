//
//  HomeView.swift
//  Habit
//
//  Created by Adriano on 9/25/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            viewModel.habitView()
                .tabItem {
                    Image(systemName: "rectangle.grid.2x2")
                    Text("Hábitos")
                }.tag(0)
            
            Text("conteudo de gráficos \(selection)")
                .tabItem {
                    Image(systemName: "chart.bar.xaxis")
                    Text("Gráficos")
                }.tag(1)
            
            viewModel.profileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Perfil")
                }.tag(2)
        }
        .background(Color.white)
        .accentColor(Color.green)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            HomeView(viewModel: HomeViewModel())
                .previewDevice("Iphone 11")
                .preferredColorScheme($0)
        }
        
    }
}
