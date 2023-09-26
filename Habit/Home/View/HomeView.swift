//
//  HomeView.swift
//  Habit
//
//  Created by user246507 on 9/25/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    var body: some View {
        Text("HomeView")
            .foregroundColor(Color.blue)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
