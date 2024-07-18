//
//  ViewController.swift
//  AnimalsApp
//
//  Created by Aditya Haryanov on 17/07/24.
//

import UIKit
import RxCocoa

final class ViewController: UIViewController {
    var param: AnimalApiRepository!
    
    convenience init(param: AnimalApiRepository) {
        self.init()
        self.param = param;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        param.getAnimals(by: "fox")
//            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { newData in
                    print(newData)
                },
                onError: { err in
                    print(err.localizedDescription)
                }, onCompleted: {
                   print("Complete")
                }
            )
    }

}

