//
//  LoadIndicator.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 14.04.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import UIKit

final class LoadIndicator: UIViewController {
    
    
    @IBOutlet weak var three: UIView!
        {
        didSet {
            three.layer.cornerRadius = three.bounds.height / 2
        }
    }
    @IBOutlet weak var two: UIView!
        {
        didSet {
            two.layer.cornerRadius = two.bounds.height / 2
        }
    }
    @IBOutlet weak var one: UIView! {
        didSet {
            one.layer.cornerRadius = one.bounds.height / 2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear( _ animeted: Bool) {
        super.viewDidAppear(animeted)
        loadingView()
    }
    
    
    func loadingView(){
        UIView.animateKeyframes(withDuration: 5, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.1) {
                self.one.alpha = 1.0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.1) {
                self.two.alpha = 1.0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.1) {
                self.three.alpha = 1.0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.1) {
                self.one.alpha = 0.0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.1) {
                self.two.alpha = 0.0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.1) {
                self.three.alpha = 0.0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.1) {
                self.one.alpha = 1.0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.1) {
                self.two.alpha = 1.0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 0.1) {
                self.three.alpha = 1.0
            }
        }, completion: { _ in
            self.performSegue(withIdentifier: "SegueLoading", sender: self)
        })
    }
}
