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
    
    var isLoading = BehaviorRelay<Bool>(value: false)
    var searchText = BehaviorRelay<String>(value: "")
    var rawAnimals: [Animal] = []
    var animals = BehaviorRelay<[Animal]>(value: [])
    
    init(repository: AnimalRepository) {
        self.repository = repository
        
        searchText
            .subscribe { [weak self] text in
                guard let self = self else { return }
                if text.isEmpty {
                    self.animals.accept(self.rawAnimals)
                } else {
                    let filtered = self.rawAnimals.filter { $0.name.contains(text) }
                    self.animals.accept(filtered)
                }
            }
            
    }
    func load() {
        Task.init { [weak self] in
            guard let self = self else { return }
            do {
                self.isLoading.accept(true)
                
                let result = try await self.fetchAnimals()
                self.rawAnimals = result
                self.animals.accept(result)
            } catch {
                print(error.localizedDescription)
            }
            
            if self.isLoading.value {
                self.isLoading.accept(false)
            }
        }
    }
    
    func fetchAnimals() async throws -> [Animal] {
        // initial Value defined
        let animalNames = ["Elephant", "Lion", "Fox", "Dog", "Shark", "Turtle", "Whale", "Penguin"]
        
        return try await repository.getAnimals(by: animalNames)
    }
}

