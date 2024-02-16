//
//  Mask.swift
//  Habit
//
//  Created by Adriano on 08/02/24.
//

import Foundation

//código padrão para máscaras
class Mask {
    static var isUpdating: Bool = false
    static var oldString: String = ""
    
    private static func replaceChars(full: String) -> String {
        full.replacingOccurrences(of: ".", with: "")
        .replacingOccurrences(of: "-", with: "")
        .replacingOccurrences(of: "(", with: "")
        .replacingOccurrences(of: ")", with: "")
        .replacingOccurrences(of: "/", with: "")
        .replacingOccurrences(of: "*", with: "")
        .replacingOccurrences(of: " ", with: "")
    }
    
    static func mask(mask: String, value: String, text: inout String) {
        let str = Mask.replaceChars(full: value)
        var withMask = ""
        var _mask = mask
        
        //condição para telefone
        if(_mask == "(##) ####-####") {
            if(value.count >= 14 && value.characterAtindex(index: 5) == "9") {
                _mask = "(##) #####-####"
            }
        }
        
        if(str <= oldString) { // deletando
            isUpdating = true
            if(_mask == "(##) #####-####" && value.count == 14) {
                _mask = "(##) ####-####"
            }
        }
        
        if(isUpdating || value.count == mask.count) {
            oldString = str
            isUpdating = false
            return
        }
        
        var i = 0
        for char in _mask {
            if(char != "#" && str.count > oldString.count) {
                withMask = withMask + String(char)
                continue
            }
            
            let unamed = str.characterAtindex(index: i)
            guard let char = unamed else { break }
            withMask = withMask + String(char)
            i = i + 1
        }
        isUpdating = true
        
        if(withMask == "(0") {
            text = ""
            return
        }
        text = withMask
    }
}
