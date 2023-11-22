//
//  GenderSelectionView.swift
//  Habit
//
//  Created by Adriano on 22/11/23.
//

import SwiftUI

struct GenderSelectionView: View {
    
    let title: String
    let genders: [Gender]
    @Binding var selectedGender: Gender?
    
    var body: some View {
        Form {
            Section(header: Text(title)) {
                List(genders, id: \.id) { item in
                    HStack {
                        Text(item.rawValue)
                        Spacer()
                        Image(systemName: "checkmark")
                            .foregroundColor(selectedGender == item ? .orange : .white)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if !(selectedGender == item) {
                            selectedGender = item
                        }
                    }
                    
                }
            }
        }
    }
}

struct GenderSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GenderSelectionView(title: "Gênero", genders: Gender.allCases, selectedGender: .constant(.male))
    }
}
