//
//  Extension + UIView.swift
//  COVID-19
//
//  Created by Denis on 2023/02/06.
//

import UIKit

extension UIView {
    func addVerticalGradientLayer() {
        let firstColor = UIColor(
            red: 210/255,
            green: 153/255,
            blue: 255/255,
            alpha: 1
        )
        
        let secondColor = UIColor(
            red: 149/255,
            green: 159/255,
            blue: 255/255,
            alpha: 1
        )
        
        let thirdColor = UIColor(
            red: 255/255,
            green: 255/255,
            blue: 255/255,
            alpha: 1
        )
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [thirdColor.cgColor, secondColor.cgColor, firstColor.cgColor]
        gradient.locations = [-0.4, 0.4, 1.0]
        gradient.startPoint = CGPoint(x: 0.3, y:0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        layer.insertSublayer(gradient, at: 0)
    }
    
    func addVerticalGradientLayerForCell() {
        let firstColor = UIColor(
            red: 253/255,
            green: 178/255,
            blue: 255/255,
            alpha: 1
        )
        
        let secondColor = UIColor(
            red: 137/255,
            green: 135/255,
            blue: 255/255,
            alpha: 1
        )
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y:0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        layer.insertSublayer(gradient, at: 0)
    }
}
