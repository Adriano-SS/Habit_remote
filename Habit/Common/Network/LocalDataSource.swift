//
//  LocalDataSource.swift
//  Habit
//
//  Created by Adriano on 26/10/23.
//

import Foundation
import Combine

class LocalDataSource {
    static var shared: LocalDataSource = LocalDataSource()
    
    private init() {
        
    }
    
    private func saveValue(value: UserAuth) {
        //usando try | catch
        do {
            try
            UserDefaults.standard.setValue(PropertyListEncoder().encode(value), forKey: "user_key")
            print("Dados de usuários armazenados com sucesso")
        }
        catch {
            print("Não foi possível salvar no dispositivo: \(error)")
        }
    }
    
    private func readValue(forKey key: String) -> UserAuth? {
        var userAuth: UserAuth?
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            userAuth = try? PropertyListDecoder().decode(UserAuth.self, from: data)
        }
        return userAuth
    }
}

extension LocalDataSource {
    func insertUserAuth(userAuth: UserAuth) {
        saveValue(value: userAuth)
    }
    
    func getUserAuth() -> Future<UserAuth?, Never> {
        let userAuth = readValue(forKey: "user_key")
        return Future { promise in
            promise(.success(userAuth))
        }
    }
}
