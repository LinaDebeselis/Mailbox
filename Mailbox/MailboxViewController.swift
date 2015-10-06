//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Lin Wang on 9/30/15.
//  Copyright © 2015 Lin Wang. All rights reserved.
//

import UIKit
import DynamicColor

class MailboxViewController: UIViewController, UIGestureRecognizerDelegate {

    //outlets
    
    @IBOutlet weak var inboxView: UIView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var feedScrollView: UIScrollView!
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var laterIconImageView: UIImageView!
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet var panOnMessage: UIPanGestureRecognizer!
    @IBOutlet weak var archiveImageView: UIImageView!
    @IBOutlet weak var messageScrollView: UIScrollView!
    @IBOutlet weak var rescheduleImageView: UIImageView!
    @IBOutlet weak var dismissRescheduleButton: UIButton!
    @IBOutlet weak var listIconImageView: UIImageView!
    @IBOutlet weak var deleteIconImageView: UIImageView!
    @IBOutlet weak var bringBackButton: UIButton!
    @IBOutlet var newLeftPan: UIPanGestureRecognizer!
    @IBOutlet weak var navBar: UISegmentedControl!
    @IBOutlet weak var feedArchive: UIImageView!
    @IBOutlet weak var archivedFeedView: UIImageView!
    
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var helpImageView: UIImageView!
    
    @IBOutlet weak var laterView: UIImageView!
    
    
    
    //Shake to undo
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == UIEventSubtype.MotionShake {
            
            messageScrollView.alpha = 1
            
            messageImageView.hidden = false
            laterIconImageView.hidden = false
//            archiveImageView.hidden = false
//            deleteIconImageView.hidden = false
            listIconImageView.hidden = false
            messageImageView.center = messageOriginalCenter
            
            feedImageView.center = CGPoint(x: feedImageView.center.x, y: feedImageView.center.y + 85)
            
            
        }
    }
    
    
    func gestureRecognizer(_: UIGestureRecognizer,shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
        return true
    }
   
    
    var laterIconImageViewCenter: CGPoint = CGPointZero
    var archiveImageViewCenter: CGPoint = CGPointZero
    var gestureStartedPoint: CGPoint = CGPointZero
    var messageOriginalCenter: CGPoint = CGPointZero
    var inViewOriginalCenter: CGPoint!
    
    
    
    //View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedScrollView.contentSize = feedImageView.image!.size
        messageScrollView.contentSize = CGSize(width: 380, height: 85)
        let leftPan = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        leftPan.edges = .Left
        inboxView.addGestureRecognizer(leftPan)
        
        self.laterView.alpha = 0
      
    }
    
    
    
    
    //Dismiss ImageViews
    
    @IBAction func dismissOnTap(sender: AnyObject) {
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.rescheduleImageView.alpha = 0
            self.listImageView.alpha = 0
            
        }) { (completed: Bool) -> Void in
            UIView.animateWithDuration(0.3, delay: 0.1, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                 self.messageScrollView.alpha = 0
                 self.feedImageView.center = CGPoint(x: self.feedImageView.center.x, y: self.feedImageView.center.y - 85)
            }, completion: nil)
        }
        
    }
    

    //Edge Pan
    
    func onEdgePan(leftPan: UIScreenEdgePanGestureRecognizer) {
        let currentPoint = leftPan.locationInView(view)
        let pointOffset = CGPoint(x: currentPoint.x - gestureStartedPoint.x, y: currentPoint.y - gestureStartedPoint.y)
        let translation = leftPan.translationInView(self.view)
        
        if leftPan.state == UIGestureRecognizerState.Began {
            print("i'm new")
            inViewOriginalCenter = inboxView.center
            inboxView.center = CGPoint(x: inViewOriginalCenter.x, y: inViewOriginalCenter.y)
        }
        
        if leftPan.state == UIGestureRecognizerState.Changed {
            inboxView.center = CGPoint(x: inViewOriginalCenter.x + translation.x, y: inViewOriginalCenter.y)
        }
        
        if leftPan.state == UIGestureRecognizerState.Ended {
            if (pointOffset.x < CGFloat(80)) && (pointOffset.x > CGFloat(0)){
                inboxView.center = CGPoint(x: 160, y: inViewOriginalCenter.y)
            } else if (pointOffset.x > CGFloat(80)) {
                inboxView.center = CGPoint(x: CGFloat(440), y: inViewOriginalCenter.y)
            }
        }
    }
    
    @IBAction func leftPanPan(sender: UIPanGestureRecognizer) {
        let currentPoint = newLeftPan.locationInView(view)
        let pointOffset = CGPoint(x: currentPoint.x - gestureStartedPoint.x, y: currentPoint.y - gestureStartedPoint.y)
        let translation = newLeftPan.translationInView(self.view)
        let velocity = sender.velocityInView(view)
        
        if newLeftPan.state == UIGestureRecognizerState.Began {
            print("i'm new")
            inViewOriginalCenter = inboxView.center
            inboxView.center = CGPoint(x: inViewOriginalCenter.x, y: inViewOriginalCenter.y)
        }
        
        if newLeftPan.state == UIGestureRecognizerState.Changed {
            
            inboxView.center = CGPoint(x: inViewOriginalCenter.x + translation.x, y: inViewOriginalCenter.y)
        }
        
        if newLeftPan.state == UIGestureRecognizerState.Ended {
            
            print(pointOffset.x)
            
            UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                if velocity.x > 0 {
                    
                    if (pointOffset.x < CGFloat(140)) && (pointOffset.x > CGFloat(0)){
                        self.inboxView.center = CGPoint(x: 160, y: self.inViewOriginalCenter.y)
                    } else if (pointOffset.x > CGFloat(140)) {
                        self.inboxView.center = CGPoint(x: CGFloat(440), y: self.inViewOriginalCenter.y)
                    }
                    
                } else if velocity.x < 0 {
                    if (pointOffset.x > CGFloat(240)) && (pointOffset.x < CGFloat(320)){
                        self.inboxView.center = CGPoint(x: 440, y: self.inViewOriginalCenter.y)
                    } else if (pointOffset.x < CGFloat(240)){
                        self.inboxView.center = CGPoint(x: 160, y: self.inViewOriginalCenter.y)
                    }
                }
                

                }, completion: nil)
            
            
    }
    }
    

   //Pan Messange
   
    @IBAction func panOnMessageTapped(sender: UIPanGestureRecognizer) {
        
        let currentPoint = sender.locationInView(view)
        let pointOffset = CGPoint(x: currentPoint.x - gestureStartedPoint.x, y: currentPoint.y - gestureStartedPoint.y)
        let velocity = sender.velocityInView(view)
        
        if panOnMessage.state == UIGestureRecognizerState.Began
        {
            messageOriginalCenter = messageImageView.center
            laterIconImageViewCenter = laterIconImageView.center
            archiveImageViewCenter = archiveImageView.center
            gestureStartedPoint = currentPoint
            
            print("Gesture began at: \(laterIconImageViewCenter)")
        }
        else if panOnMessage.state == UIGestureRecognizerState.Changed
        {
            print("Gesture changed at: pointOffset= \(pointOffset)")
            
            if (pointOffset.x > CGFloat(-60)) {
                laterIconImageView.center = laterIconImageViewCenter
                messageScrollView.backgroundColor = UIColor(hex: 0xbcbcbc)
                laterIconImageView.alpha = 0.6
            } else if (pointOffset.x < CGFloat(-60) && pointOffset.x > CGFloat(-260)) {
                laterIconImageView.center = laterIconImageViewCenter
                laterIconImageView.center = CGPoint(
                    x: laterIconImageViewCenter.x + pointOffset.x - CGFloat(-60),
                    y: laterIconImageViewCenter.y)
                messageScrollView.backgroundColor = UIColor(hex: 0xf9ce4c)
                laterIconImageView.alpha = 1
                laterIconImageView.hidden = false
                listIconImageView.hidden = true
            } else if pointOffset.x < CGFloat(-260) && pointOffset.x > CGFloat(-320) {
                laterIconImageView.center = laterIconImageViewCenter
                laterIconImageView.center = CGPoint(
                    x: laterIconImageViewCenter.x + pointOffset.x - CGFloat(-60),
                    y: laterIconImageViewCenter.y)
                messageScrollView.backgroundColor = UIColor(hex: 0xd0a67d)
                laterIconImageView.hidden = true
                listIconImageView.hidden = false
            }

            
            if (pointOffset.x < CGFloat(60) && pointOffset.x > (0)) {
                archiveImageView.center = archiveImageViewCenter
                messageScrollView.backgroundColor = UIColor(hex: 0xbcbcbc)
                archiveImageView.alpha = 0.2
            } else if (pointOffset.x < CGFloat(260) && pointOffset.x > CGFloat(60)) {
                archiveImageView.center = archiveImageViewCenter
                archiveImageView.center = CGPoint(
                    x: archiveImageViewCenter.x + pointOffset.x - CGFloat(60),
                    y: archiveImageViewCenter.y)
                messageScrollView.backgroundColor = UIColor(hex: 0x8ace68)
                archiveImageView.alpha = 1
                deleteIconImageView.hidden = true
                archiveImageView.hidden = false
            } else if (pointOffset.x < CGFloat(320) && pointOffset.x > CGFloat(260)) {
                archiveImageView.center = archiveImageViewCenter
                archiveImageView.center = CGPoint(
                    x: archiveImageViewCenter.x + pointOffset.x - CGFloat(60),
                    y: archiveImageViewCenter.y)
                messageScrollView.backgroundColor = UIColor(hex: 0xda6139)
                deleteIconImageView.hidden = false
                archiveImageView.hidden = true
                
            }

        }
        else if panOnMessage.state == UIGestureRecognizerState.Ended
        {
            print("Gesture ended at: pointOffset= \(pointOffset)")
            
            UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.6, options: [], animations: {
                
                if velocity.x > 0 {
                    if pointOffset.x > CGFloat(0) && pointOffset.x < CGFloat(60) {
                        self.messageImageView.center = self.messageOriginalCenter
                    }
                    if pointOffset.x > CGFloat(60) && pointOffset.x < CGFloat(230) {
                        self.messageImageView.hidden = true
                        self.laterIconImageView.hidden = true
                        self.archiveImageView.hidden = true
                        self.deleteIconImageView.hidden = true
                        UIView.animateWithDuration(0.3, delay: 0.1, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                            self.messageScrollView.alpha = 0
                            self.feedImageView.center = CGPoint(x: self.feedImageView.center.x, y: self.feedImageView.center.y - 85)
                            }, completion: nil)
                    }
                    
                    if pointOffset.x > CGFloat(230) && pointOffset.x < CGFloat(320) {
                        self.messageImageView.hidden = true
                        self.laterIconImageView.hidden = true
                        self.archiveImageView.hidden = true
                        self.deleteIconImageView.hidden = true
                        self.listImageView.hidden = true
                        UIView.animateWithDuration(0.3, delay: 0.1, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                            self.messageScrollView.alpha = 0
                            self.feedImageView.center = CGPoint(x: self.feedImageView.center.x, y: self.feedImageView.center.y - 85)
                            }, completion: nil)
                                            }
                    
                } else if velocity.x < 0 {
                    
                    if pointOffset.x > CGFloat(-60) && pointOffset.x < CGFloat(0) {
                        self.messageImageView.center = self.messageOriginalCenter
                    } else if pointOffset.x > (-260) && pointOffset.x < (-60) {
                        self.messageImageView.hidden = true
                
                        UIView.animateWithDuration(0.2, delay: 0.15, options: [], animations: { () -> Void in
                            self.rescheduleImageView.alpha = 1
                            self.laterIconImageView.hidden = true
                            self.listIconImageView.hidden = true
                            self.archiveImageView.hidden = true
                            }, completion: nil)
                    } else if pointOffset.x > (-320) && pointOffset.x < (-260){
                        self.messageImageView.hidden = true

                            self.listImageView.alpha = 1
                            self.laterIconImageView.hidden = true
                            self.archiveImageView.hidden = true
                            self.deleteIconImageView.hidden = true
                            self.listIconImageView.hidden = true
                    }

                    }
                            self.laterIconImageView.center = self.laterIconImageViewCenter
                            self.archiveImageView.center = self.archiveImageViewCenter
                }, completion: nil)
            
                gestureStartedPoint = CGPointZero
                return
        }
        
        messageImageView.center = CGPoint(
            x: messageOriginalCenter.x + pointOffset.x,
            y: messageOriginalCenter.y
        )
        }
    
    //Nav bar
    
    @IBAction func navBarTapped(sender: AnyObject) {
        
        
       if (navBar.selectedSegmentIndex == 2) {
            navBar.tintColor = UIColor(hex: 0x8ace68)
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.feedImageView.center = CGPoint(x: -160.0, y: self.feedImageView.center.y)
                self.archivedFeedView.center = CGPoint(x: 160.0, y: self.archivedFeedView.center.y)
                self.laterView.center = CGPoint(x: -160.0-320.0, y: self.laterView.center.y)
                self.searchImageView.center = CGPoint(x: -160.0, y: self.searchImageView.center.y)
                self.messageScrollView.center = CGPoint(x: -160.0, y: self.messageScrollView.center.y)
                self.helpImageView.center = CGPoint(x: -160.0, y: self.helpImageView.center.y)
                self.laterView.alpha = 1
                self.archivedFeedView.alpha = 1

            })
        } else if (navBar.selectedSegmentIndex == 1) {
            navBar.tintColor = UIColor(hex: 0x44AAD2)
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.feedImageView.center = CGPoint(x: 160.0, y: self.feedImageView.center.y)
                self.laterView.center = CGPoint(x: -160.0, y: self.laterView.center.y)
                self.archivedFeedView.center = CGPoint(x: 320.0+160.0, y: self.archivedFeedView.center.y)
                self.searchImageView.center = CGPoint(x: 160.0, y: self.searchImageView.center.y)
                self.messageScrollView.center = CGPoint(x: 160.0, y: self.messageScrollView.center.y)
                self.helpImageView.center = CGPoint(x: 160.0, y: self.helpImageView.center.y)
                self.laterView.alpha = 0
                self.archivedFeedView.alpha = 1
            })
            
        }
        
        else if (navBar.selectedSegmentIndex == 0) {
            navBar.tintColor = UIColor(hex: 0xf9ce4c)
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.feedImageView.center = CGPoint(x: 480.0, y: self.feedImageView.center.y)
                self.laterView.center = CGPoint(x: 160.0, y: self.laterView.center.y)
                self.archivedFeedView.center = CGPoint(x: 480.0, y: self.archivedFeedView.center.y)
                self.searchImageView.center = CGPoint(x: 480.0, y: self.searchImageView.center.y)
                self.messageScrollView.center = CGPoint(x: 480.0, y: self.messageScrollView.center.y)
                self.helpImageView.center = CGPoint(x: 480.0, y: self.helpImageView.center.y)
                self.laterView.alpha = 1
                self.archivedFeedView.alpha = 0
                
                
            })

        }
    }
    
}





        