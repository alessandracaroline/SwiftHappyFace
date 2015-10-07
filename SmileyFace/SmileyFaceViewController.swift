//
//  SmileyFaceViewController.swift
//  SmileyFace
//
//  Created by Alessandra Caroline Faisst on 06/10/15.
//  Copyright © 2015 Alessandra Caroline Faisst. All rights reserved.
//

import UIKit

class SmileyFaceViewController: UIViewController, FaceViewDataSource
{
    var happiness: Int = 15 { // 0 = very sad, 100 = ecstatic
        didSet {
            happiness = min(max(happiness, 0), 100)
            updateUI()
        }
    }
    
    private struct Constants {
        static let HappinessGestureScale: CGFloat = 4
    }
    
    // argument renamed from sender to gesture
    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default: break
        }
    }
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
//            faceView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "changeHappiness")) // // this would also work
        }
    }
    

// Test with Slider
//    @IBAction func slideHappiness(sender: UISlider) {
//        happiness = Int(sender.value)
//    }
    
    
    
    func updateUI() {
        faceView.setNeedsDisplay()
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness-50)/50
    }
    

}
