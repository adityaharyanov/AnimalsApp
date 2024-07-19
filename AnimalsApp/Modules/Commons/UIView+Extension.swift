//
//  UIView+Extension.swift
//  AnimalsApp
//
//  Created by Aditya Haryanov on 19/07/24.
//

import Foundation
import UIKit

extension UIView {
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor, padding: padding)
    }
    
    func anchorFill(to layoutGuide: UILayoutGuide) {
        anchor(top: layoutGuide.topAnchor, leading: layoutGuide.leadingAnchor, bottom: layoutGuide.bottomAnchor, trailing: layoutGuide.trailingAnchor)
    }
    
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func anchorTop(padding: CGFloat = 0) {
        anchorTop(nil, padding: padding)
    }
    
    func anchorBottom(padding: CGFloat = 0) {
        anchorBottom(nil, padding: padding)
    }
    
    func anchorLeading(padding: CGFloat = 0) {
        anchorLeading(nil, padding: padding)
    }
    
    func anchorTrailing(padding: CGFloat = 0) {
        anchorTrailing(nil, padding: padding)
    }
    
    func anchorTop(_ anchor: NSLayoutYAxisAnchor? , padding: CGFloat = 0) {
        if let anchor = anchor ?? superview?.topAnchor {
            topAnchor.constraint(equalTo: anchor, constant: padding).isActive = true
        }
    }
    
    func anchorBottom(_ anchor: NSLayoutYAxisAnchor?, padding: CGFloat = 0)  {
        if let anchor = anchor ?? superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: anchor, constant: -padding).isActive = true
        }
    }
    
    func anchorLeading(_ anchor: NSLayoutXAxisAnchor?, padding: CGFloat = 0) {
        if let anchor = anchor ?? superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: anchor, constant: padding).isActive = true
        }
    }
    
    func anchorTrailing(_ anchor: NSLayoutXAxisAnchor?, padding: CGFloat = 0) {
        if let anchor = anchor ?? superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: anchor, constant: -padding).isActive = true
        }
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
