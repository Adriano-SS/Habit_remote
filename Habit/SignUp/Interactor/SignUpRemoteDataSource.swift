//
//  SignUpRemoteDataSource.swift
//  Habit
//
//  Created by Adriano on 25/10/23.
//

import Foundation
import Combine

class SignUpRemoteDataSource {
    static var shared: SignUpRemoteDataSource = SignUpRemoteDataSource()

    private init() {
    }
    
    func postUser(request: SignUpRequest) -> Future<Bool, AppError> {
        return Future { promise in
            WebService.call(path: .postuser, method: .post, body: request) { result in
                switch result {
                case .failure(let error, let data):
                    if let data = data {
                        if error == .badRequest{
                            let decoder = JSONDecoder()
                            let response = try? decoder.decode(ErrorResponse.self, from: data)
                            promise(.failure(AppError.response(message: response?.detail ?? "Erro no servidor")))
                        }
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



