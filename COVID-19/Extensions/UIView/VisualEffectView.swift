//
//  Extension + UIVisualEffectView.swift
//  COVID-19
//
//  Created by Denis on 2023/04/11.
//

import UIKit

final class VisualEffect: UIVisualEffectView {
    func setBlurView() -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.layer.masksToBounds = true
        blurView.clipsToBounds = true
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.layer.shadowColor = UIColor.black.cgColor
        blurView.layer.shadowRadius = 7
        blurView.layer.shadowOpacity = 0.4
        blurView.layer.shadowOffset = CGSize(width: 7, height: 7)
        
        return blurView
    }
}
