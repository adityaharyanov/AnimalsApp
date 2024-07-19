//
//  AnimalRepository.swift
//  AnimalsApp
//
//  Created by Aditya Haryanov on 17/07/24.
//

import Foundation

protocol AnimalRepository {
    func getAnimals(by keywords: [String]) async throws -> [Animal]
    func getAnimals(by keyword: String) async throws -> [Animal]
}

class AnimalApiRepository: AnimalRepository {
    func getAnimals(by keywords: [String]) async throws -> [Animal] {
        var result = try await withThrowingTaskGroup(of: [Animal].self) { group in
            for keyword in keywords {
                group.addTask{ [weak self] in
                    let image = try await self?.getAnimals(by: keyword)
                    return image ?? []
                }
            }
            
            var animals: [Animal] = []
            for try await result in group {
                animals.append(contentsOf: result)
            }
                    
            return animals
        }
        
        result = result.sorted { $0.name < $1.name }
        
        return result;
    }
    
    func getAnimals(by keyword: String) async throws -> [Animal] {
        return try await HttpService.get(of: [Animal].self, endpoint: AnimalApiService.getAnimals(by: keyword))
    }
}


