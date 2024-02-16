//
//  EditTextView.swift
//  Habit
//
//  Created by Adriano on 9/29/23.
//

import SwiftUI
import Foundation

struct EditTextView: View {
    @Binding var text: String

    
    var placeholder: String = ""
    var mask: String? = nil
    var keyboard: UIKeyboardType = .default
    var error: String? = nil
    var failure: Bool? = nil
    var isSecure: Bool = false
    var autocapitalization: UITextAutocapitalizationType = .none
    
    
    var body: some View {
        VStack {
            if isSecure {
                SecureField(placeholder, text: $text)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyboard)
                    .textFieldStyle(CustomTextFieldStyle())
            }
            else{
                TextField(placeholder, text: $text)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyboard)
                    .autocapitalization(autocapitalization)
                    .textFieldStyle(CustomTextFieldStyle())
                    .onChange(of: text) { value in
                        if let mask = mask {
                            Mask.mask(mask: mask, value: value, text: &text)
                        }
                    }
            }            
            
            if let error = error, !text.isEmpty, failure == true {
                Text(error)
                    .foregroundColor(Color.red)
            }
        }
        .padding(.bottom, 10)
    }
}
