//
//  ProfileRemoteDataSource.swift
//  Habit
//
//  Created by Adriano on 27/11/23.
//

import Foundation
import Combine

class ProfileRemoteDataSource {
    static var shared: ProfileRemoteDataSource = ProfileRemoteDataSource()

    private init() {
    }
    
    func fectchUser() -> Future<ProfileResponse, AppError> {
        return Future { promise in
            WebService.call(path: .fecthUser, method: .get) { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(ErrorResponse.self, from: data)
                        promise(.failure(AppError.response(message: response?.detail ?? "Erro no servidor")))
                    }
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(ProfileResponse.self, from: data)
                    guard let res = response else {
                        print("Log: Error Parser \(String(data: data, encoding: .utf8)!)")
                        return
                    }
                    promise(.success(res))
                    break
                    
                }
            }
        }
        
    }
    
    func updateUser(userId: Int, request profileRequest: ProfileRequest) -> Future<ProfileResponse, AppError> {
        return Future { promise in
            let path = String(format: WebService.Endpoint.updateUser.rawValue, userId)
            WebService.call(path: path, method: .put, body: profileRequest) { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(ErrorResponse.self, from: data)
                        promise(.failure(AppError.response(message: response?.detail ?? "Erro no servidor")))
                    }
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(ProfileResponse.self, from: data)
                    guard let res = response else {
                        print("Log: Error Parser \(String(data: data, encoding: .utf8)!)")
                        return
                    }
                    promise(.success(res))
                    break
                    
                }
            }
        }
    }
    
}
