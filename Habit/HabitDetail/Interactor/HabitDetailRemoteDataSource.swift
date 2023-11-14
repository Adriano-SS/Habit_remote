//
//  HabitDetailRemoteDataSource.swift
//  Habit
//
//  Created by Adriano on 14/11/23.
//

import Foundation
import Combine

class HabitDetailRemoteDataSource {
    //Singleton
    static var shared: HabitDetailRemoteDataSource = HabitDetailRemoteDataSource()
    
    private init() {
    }
    
    func save(habitId: Int, request: HabitValueRequest) -> Future<Bool, AppError> {
        return Future<Bool, AppError> { promise in
            
            //troca o %d no endpoint pelo habitId
            let path = String(format: WebService.Endpoint.habitValues.rawValue, habitId)
            
            WebService.call(path: path, method: .post, body: request) { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                        //completion(nil, response)
                        promise(.failure(.response(message: response?.detail.message ?? "Erro desconhecido no servidor")))
                        
                    }
                    break
                case .success(_):
                    promise(.success(true))
                    break
                }
            }
        }
        
    }
}
