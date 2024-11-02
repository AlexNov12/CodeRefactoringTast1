//
//  CardsService.swift
//  CodeRefactoringTast1
//
//  Created by Александр Новиков on 31.10.2024.
//

import Foundation

protocol CardsServiceProtocol {
    func loadCardsInfo(byCardID cardID: String, completion: @escaping (Result<CardResponse, Error>) -> Void)
}

final class CardsService: CardsServiceProtocol {
    func loadCardsInfo(byCardID cardID: String, completion: @escaping (Result<CardResponse, Error>) -> Void) {
        guard let url = URL(string: "https://api.bank.com/v1/getCards?cardID=\(cardID)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(NSError(domain: "Invalid data", code: 0, userInfo: nil)))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(CardResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
