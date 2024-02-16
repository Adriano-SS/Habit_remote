//
//  ProfileEditTextView.swift
//  Habit
//
//  Created by Adriano on 16/02/24.
//

import Foundation
import SwiftUI

struct ProfileEditTextView: View {
    
    @Binding var text: String

    var placeholder: String = ""
    var mask: String? = nil
    var keyboard: UIKeyboardType = .default
    var autocapitalization: UITextAutocapitalizationType = .none
    
    
    var body: some View {
        VStack {
            TextField(placeholder, text: $text)
                .foregroundColor(Color("textColor"))
                .keyboardType(keyboard)
                .autocapitalization(autocapitalization)
                .multilineTextAlignment(.trailing)
                .onChange(of: text) { value in
                    if let mask = mask {
                        Mask.mask(mask: mask, value: value, text: &text)
                    }
                    
                }
        }
        .padding(.bottom, 10)
    }
}
