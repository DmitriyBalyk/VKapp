//
//  GalleryViewController.swift
//  VK_feed
//
//  Created by Дмитрий Балык on 19.04.2020.
//  Copyright © 2020 DmitriyBalyk. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var imagePhoto: UIImageView!
    
    let arrayFoto: [String] = ["1"]
    var countFoto: Int = 0
    var foto: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePhoto.image = UIImage(named: arrayFoto[countFoto])
        
    }
    //в процессе завершения
    
    /*@IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleView: UIImageView!
    
    var friends2 = [String]()
    var i = 0
    var interactiveAnimator = UIViewPropertyAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.isUserInteractionEnabled = true
        image.layer.cornerRadius = 30
        
        guard friends2.count > 0 else { return
            image.image = UIImage(named: "4")
        }
        image.image = UIImage(named: friends2[i])
        
        
    }
    
    
    func imageSwipe(animations: @escaping () -> Void) {
        UIView.animateKeyframes(withDuration: 0.5,
                                delay: 0,
                                options: [],
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0,
                                                       relativeDuration: 0.2,
                                                       animations: {
                                                        animations()
                                                        
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0.2,
                                                       relativeDuration: 0.2,
                                                       animations: {
                                                        self.image.alpha = 0
                                                        
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0.4,
                                                       relativeDuration: 0.2,
                                                       animations: {
                                                        self.image.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                                                        
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0.6,
                                                       relativeDuration: 0.2,
                                                       animations: {
                                                        self.image.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
                                                        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.3, execute: {
                                                            self.image.image = UIImage(named: self.friends2[self.i])
                                                        })
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0.8,
                                                       relativeDuration: 0.2,
                                                       animations: {
                                                        self.image.alpha = 1
                                                        self.image.transform = CGAffineTransform(scaleX: 1, y: 1)
                                    })
        },
                                completion: nil)
        
    }
    
    func dumpingAnimate() {
        interactiveAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                     dampingRatio: 0.5,
                                                     animations: {
                                                        self.image.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
        })
        interactiveAnimator.startAnimation()
    }
    
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        let centerView = self.view.bounds.width / 2
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y)
        }
        recognizer.setTranslation(.zero, in: self.view)
        let imageCenterX = image.center.x
        
        if recognizer.state == .ended {
            
            switch i {
                
            case 0:
                if friends2.count > 1 {
                    
                    if imageCenterX < centerView {
                        imageSwipe {
                            self.image.frame.origin.x = -300
                            self.i += 1
                        }
                    } else {
                        dumpingAnimate()
                    }
                    
                } else {
                    if imageCenterX > centerView || imageCenterX < centerView {
                        dumpingAnimate()
                    }
                }
                
            case 1..<friends2.count - 1:
                
                imageSwipe {
                    if imageCenterX > centerView {
                        self.image.frame.origin.x = 400
                        self.i -= 1
                    } else {
                        self.image.frame.origin.x = -300
                        self.i += 1
                    }
                }
                
            case friends2.count - 1:
                
                if imageCenterX > centerView {
                    imageSwipe {
                        self.image.frame.origin.x = 400
                        self.i -= 1
                    }
                } else {
                    dumpingAnimate()
                }
                
            default:
                break
            }
        }
    }*/
    
}
