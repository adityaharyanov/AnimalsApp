//
//  Rx+Extension.swift
//  AnimalsApp
//
//  Created by Aditya Haryanov on 19/07/24.
//

import Foundation
import RxSwift
import RxCocoa

extension BehaviorRelay where Element: RangeReplaceableCollection {
    func acceptAppending(_ element: Element) {
        accept(value + element)
    }
    
    func acceptAppending(_ element: Element.Element) {
        accept(value + [element])
    }
}

extension Reactive where Base : UICollectionView {
    
    //TODO : still emits multiple times, need to improve some kinda distinctuntilchanged things
    func onReachBottom(withOffset bottomOffset: CGFloat) -> Observable<Void> {
        return base.rx.contentOffset
            .map({ $0.y })
            .filter({ contentOffsetY in
                return contentOffsetY + base.frame.size.height + bottomOffset > base.contentSize.height
            })
            .distinctUntilChanged()
            .throttle(.seconds(5), scheduler: MainScheduler.instance)
            .map({ _ in
                return ()
            })
            
    }
}
