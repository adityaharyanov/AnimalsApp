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
    var image: ImageApiRepository!
    
    convenience init(param: AnimalApiRepository, image: ImageApiRepository) {
        self.init()
        self.param = param;
        self.image = image;
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
        
        image.getImages(by: "fox", page: 1)
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

