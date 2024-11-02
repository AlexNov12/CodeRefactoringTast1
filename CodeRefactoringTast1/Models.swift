//
//  Models.swift
//  CodeRefactoringTast1
//
//  Created by Александр Новиков on 31.10.2024.
//
struct CardResponse: Codable {
    let card: Card
    let requestID: String
}

extension CardResponse {
    struct Card: Codable {
        let number: String
        let name: String
    }
}
