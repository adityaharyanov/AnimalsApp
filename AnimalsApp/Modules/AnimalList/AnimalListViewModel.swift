//
//  AnimalListViewModel.swift
//  AnimalsApp
//
//  Created by Aditya Haryanov on 17/07/24.
//

import Foundation
import RxSwift
import RxCocoa


final class AnimalListViewModel {
    
    private let repository: AnimalRepository
    let disposeBag = DisposeBag()
    
//    var isLoading = BehaviorRelay<Bool>(value: false)
    var searchText = BehaviorRelay<String>(value: "")
    var animals = BehaviorRelay<[Animal]>(value: [])
    
    init(repository: AnimalRepository) {
        self.repository = repository
    }
    func load() {
        Task.init {
            do {
//                isLoading.accept(true)
                
                let result = try await fetchAnimals()
                animals.accept(result)
                
//                if isLoading.value {
//                    isLoading.accept(false)
//                }
            } catch {
                print(error.localizedDescription)
//                if isLoading.value {
//                    isLoading.accept(false)
//                }
            }
        }
    }
    
    func fetchAnimals() async throws -> [Animal] {
        
        // initial Value defined
        let animalNames = ["Elephant", "Lion", "Fox", "Dog", "Shark", "Turtle", "Whale", "Penguin"]
        
        let result = try await withThrowingTaskGroup(of: [Animal].self) { group in
            for name in animalNames {
                group.addTask{ [weak self] in
                    let image = try await self?.repository.getAnimals(by: name)
                    return image ?? []
                }
            }
            
            var animals: [Animal] = []
            for try await result in group {
                animals.append(contentsOf: result)
            }
                    
            return animals
        }
        
        return result;
    }
}

