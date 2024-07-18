//
//  AnimalRepository.swift
//  AnimalsApp
//
//  Created by Aditya Haryanov on 17/07/24.
//

import Foundation
import RxSwift

protocol AnimalRepository {
    func getAnimals(by keyword: String) -> Observable<[Animal]>
}

class AnimalApiRepository: AnimalRepository {
    func getAnimals(by keyword: String) -> Observable<[Animal]> {
        return HttpService.get(of: [Animal].self, endpoint: AnimalApiService.getAnimals(by: keyword))
            .do(onNext: { print($0.first?.name ?? "No Data") })
    }
}


