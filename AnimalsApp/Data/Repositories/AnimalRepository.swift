//
//  AnimalRepository.swift
//  AnimalsApp
//
//  Created by Aditya Haryanov on 17/07/24.
//

import Foundation

protocol AnimalRepository {
    func getAnimals(by keyword: String) async throws -> [Animal]
}

class AnimalApiRepository: AnimalRepository {
    func getAnimals(by keyword: String) async throws -> [Animal] {
        return try await HttpService.get(of: [Animal].self, endpoint: AnimalApiService.getAnimals(by: keyword))
    }
}


