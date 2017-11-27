//
//  TrackingButton.swift
//  Maps
//
//  Created by Alex on 25/11/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

class TrackingButton: CustomButton {

    // MARK: Properties
    private var trackingPositionActive = Bool()
    private var timerAnimation = Timer()
    
    // MARK: Public Functions
    public func isTrackingPositionActive() -> Bool {
        return trackingPositionActive
    }
    
    public func setTrackingButton(active: Bool) {
        trackingPositionActive = active
        setAppearanceButton(active: active)
    }
    
    // MARK: Private Functions
    private func setAppearanceButton(active: Bool) {
        if active {
            self.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            self.setImage(UIImage.init(named: "stop_icon"), for: .normal)
            self.imageEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            
        } else {
            self.backgroundColor = #colorLiteral(red: 0, green: 0.5647058824, blue: 0.3176470588, alpha: 1)
            self.setImage(UIImage.init(named: "route_icon"), for: .normal)
            self.imageEdgeInsets = UIEdgeInsets(top: 13, left: 13, bottom: 13, right: 13)
        }
        animationImageView(active: active)
    }
    
    private func animationImageView(active: Bool) {
        if active {
            timerAnimation = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(animateAlphaImage), userInfo: nil, repeats: true)
        } else {
            self.imageView?.alpha = 1.0
            timerAnimation.invalidate()
        }
    }
    
    @objc private func animateAlphaImage() {
        UIView.animate(withDuration: 1.0, animations: {
            self.imageView?.alpha = 0.3
        }) { (complete) in
            UIView.animate(withDuration: 1.0, animations: {
                self.imageView?.alpha = 1.0
            })
        }
    }
}
