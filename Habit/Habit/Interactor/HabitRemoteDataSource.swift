//
//  HabitRemoteDataSource.swift
//  Habit
//
//  Created by Adriano on 08/11/23.
//

import Foundation
import Combine

class HabitRemoteDataSource {
    static var shared: HabitRemoteDataSource = HabitRemoteDataSource()

    private init() {
    }
    
    func fetchHabits() -> Future<[HabitResponse], AppError> {
        return Future<[HabitResponse], AppError> { promise in
            WebService.call(path: .habits, method: .get) { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                        promise(.failure(AppError.response(message: response?.detail.message
                                                           ?? "Erro no servidor")))
                    }
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode([HabitResponse].self, from: data)
                    guard let res = response else {
                        print("Log: Error Parse \(String(data: data, encoding: .utf8)!)")
                        return
                    }
                    promise(.success(res))
                    break
                }
            }
        }
        
    }
    
}
