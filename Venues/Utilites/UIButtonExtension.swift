//
//  UIButtonExtension.swift
//  Venues
//
//  Created by Aivars Meijers on 04/11/2018.
//  Copyright © 2018 Aivars Meijers. All rights reserved.
//

import UIKit

extension UIButton {
    
     func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }
    
    func flash() {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        layer.add(flash, forKey: nil)
    }
    
    
    func shake() {
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
    
    func roundCorners() {
        
        layoutIfNeeded()
        layer.cornerRadius = frame.size.height/2
        layer.masksToBounds = true
    }
    
    func ovalCorners(radius: CGFloat) {
        
        layoutIfNeeded()
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    
    func setBorder(color: UIColor, width: CGFloat) {
        
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    func setShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.masksToBounds = false
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
    }
}
