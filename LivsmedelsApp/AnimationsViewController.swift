//
//  AnimationsViewController.swift
//  LivsmedelsApp
//
//  Created by Hristijan Bocevski on 2017-08-01.
//  Copyright © 2017 Hristijan Bocevski. All rights reserved.
//

import UIKit

class AnimationsViewController: UIViewController {

    @IBOutlet weak var apple: UIImageView!
    @IBOutlet weak var banana: UIImageView!
    
    var dynamicAnimator : UIDynamicAnimator!
    var gravity : UIGravityBehavior!
    var collision : UICollisionBehavior!
    var snap : UISnapBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apple.alpha = 0
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items:[banana])
        
        dynamicAnimator.addBehavior(gravity)
        collision = UICollisionBehavior(items: [banana])
        collision.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(collision)
        snap = UISnapBehavior(item: banana,snapTo: view.center)
        snap.damping = 5
        dynamicAnimator.addBehavior(snap)
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
            self.apple.alpha = 1
            self.moveApple(position: self.banana.center)
        }
    }
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        let tapPosition = sender.location(in: view)
        self.moveApple(position: tapPosition)
    }
    
    func moveApple(position: CGPoint) {
        UIView.beginAnimations("Move Apple", context: nil)
        UIView.setAnimationDuration(1)
        UIView.setAnimationCurve(.linear)
        apple.center = position
        UIView.commitAnimations()
    }
}
