//
//  EditTextView.swift
//  Habit
//
//  Created by user246507 on 9/29/23.
//

import SwiftUI

struct EditTextView: View {
    var placeholder: String = ""
    @Binding var text: String
    var keyboard: UIKeyboardType = .default
    var error: String? = nil
    var failure: Bool? = nil
    var isSecure: Bool = false
    
    
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
                    .textFieldStyle(CustomTextFieldStyle())
            }            
            
            if let error = error, !text.isEmpty, failure == true {
                Text(error)
                    .foregroundColor(Color.red)
            }
        }
        .padding(.bottom, 10)
    }
}
