//
//  TweenObject.swift
//  GTween
//
//  Created by Goon Nguyen on 10/13/14.
//  Copyright (c) 2014 Goon Nguyen. All rights reserved.
//

import Foundation
import UIKit

let alpha = "alpha"
let x = "x"
let y = "y"
let scaleX = "scaleX"
let scaleY = "scaleY"
let width = "width"
let height = "height"
let rotation = "rotation"
let ease = "ease"
let delay = "delay"

class TweenObject:NSObject {
    var loop:CADisplayLink!
    
    /*var fromValue:Float!
    var toValue:Float!*/
    var changeValue:Float!
    
    var speed:Double = 1
    var target:CCNode!
    var targetFrame:CGRect!
    var currentTime:Double = 0
    var totalTime:Double = 0
    var delayTime:Double = 0
    
    var repeat:Int = 0
    var repeatCount:Int = 0
    
    var _time:Float!
    
    var isPaused:Bool = false;
    var isStarted:Bool = false;
    var isYoyo:Bool = false;
    
    var inputParams:Dictionary<String, Any>!
    var tweenParams:[String: AnyObject]!
    
    var easeNumber:Float?
    var easeType:String = "Linear.easeNone" //default
    
    typealias OnCompleteType = ()->Void
    
    var runOnComplete:(()->())?
    var runOnUpdate:((Float)->())?
    var runOnStart:(()->())?
    
    // tween values
    var toX:CGFloat!
    var toY:CGFloat!
    var toWidth:CGFloat!
    var toHeight:CGFloat!
    var toScaleX:CGFloat!
    var toScaleY:CGFloat!
    var toAlpha:CGFloat!
    var toRotation:CGFloat!
    
    // origin values
    var originX:CGFloat!
    var originY:CGFloat!
    var originWidth:CGFloat!
    var originHeight:CGFloat!
    var originScaleX:CGFloat!
    var originScaleY:CGFloat!
    var originRotation:CGFloat!
    var originAlpha:CGFloat!
    
    init(_target:CCNode, time:Float, params:[String: Any], events:[String: Any] = Dictionary()){
        target = _target
        _time = time;
        inputParams = params;
        
        if var inputEase = params["ease"] as? String {
            easeType = String(inputEase)
        }
        
        if var delayInInt = params["delay"] as? Int {
            delayTime = Double(delayInInt)
        } else if let delayInDouble = params["delay"] as? Float {
            delayTime = Double(delayInDouble)
        } else if let delayInFloat = params["delay"] as? Double {
            delayTime = delayInFloat
        }
        
        if let isGetYoyo = params["yoyo"] as? Bool {
            isYoyo = isGetYoyo
        }
        
        runOnComplete  = events["onComplete"] as? (()->Void)
        runOnUpdate    = events["onUpdate"] as? ((Float)->())
        runOnStart     = events["onStart"] as? (()->Void)
        
        if var xInInt = params["x"] as? Int {
            toX = CGFloat(xInInt)
        } else if let xInDouble = params["x"] as? Double {
            toX = CGFloat(xInDouble)
        } else if let xInFloat = params["x"] as? Float {
            toX = CGFloat(xInFloat)
        } else if let xInCGFloat = params["x"] as? CGFloat {
            toX = xInCGFloat
        }
        
        if let yInInt = params["y"] as? Int {
            toY = CGFloat(yInInt)
        } else if let yInDouble = params["y"] as? Double {
            toY = CGFloat(yInDouble)
        } else if let yInFloat = params["y"] as? Float {
            toY = CGFloat(yInFloat)
        } else if let yInCGFloat = params["y"] as? CGFloat {
            toY = yInCGFloat
        }
        
        if let widthInInt = params["width"] as? Int {
            toWidth = CGFloat(widthInInt)
        } else if let widthInDouble = params["width"] as? Double {
            toWidth = CGFloat(widthInDouble)
        } else if let widthInFloat = params["width"] as? Float {
            toWidth = CGFloat(widthInFloat)
        } else if let wInCGFloat = params["width"] as? CGFloat {
            toWidth = wInCGFloat
        }
        
        if let heightInInt = params["height"] as? Int {
            toHeight = CGFloat(heightInInt)
        } else if let heightInDouble = params["height"] as? Double {
            toHeight = CGFloat(heightInDouble)
        } else if let heightInFloat = params["height"] as? Float {
            toHeight = CGFloat(heightInFloat)
        } else if let hInCGFloat = params["height"] as? CGFloat {
            toHeight = hInCGFloat
        }
        
        if let scaleXInInt = params["scaleX"] as? Int {
            toScaleX = CGFloat(scaleXInInt)
        } else if let scaleXInDouble = params["scaleX"] as? Double {
            toScaleX = CGFloat(scaleXInDouble)
        } else if let scaleXInFloat = params["scaleX"] as? Float {
            toScaleX = CGFloat(scaleXInFloat)
        } else if let sxInCGFloat = params["scaleX"] as? CGFloat {
            toScaleX = sxInCGFloat
        }
        
        if let scaleYInInt = params["scaleY"] as? Int {
            toScaleY = CGFloat(scaleYInInt)
        } else if let scaleYInDouble = params["scaleY"] as? Double {
            toScaleY = CGFloat(scaleYInDouble)
        } else if let scaleYInFloat = params["scaleY"] as? Float {
            toScaleY = CGFloat(scaleYInFloat)
        } else if let syInCGFloat = params["scaleY"] as? CGFloat {
            toScaleY = syInCGFloat
        }
        
        if let alphaInInt = params["alpha"] as? Int {
            toAlpha = CGFloat(alphaInInt)
        } else if let alphaInDouble = params["alpha"] as? Double {
            toAlpha = CGFloat(alphaInDouble)
        } else if let alphaInFloat = params["alpha"] as? Float {
            toAlpha = CGFloat(alphaInFloat)
        } else if let aInCGFloat = params["alpha"] as? CGFloat {
            toAlpha = aInCGFloat
        }
        
        if let rotationInInt = params["rotation"] as? Int {
            toRotation = CGFloat(rotationInInt)
        } else if let rotationInDouble = params["rotation"] as? Double {
            toRotation = CGFloat(rotationInDouble)
        } else if let rotationInFloat = params["rotation"] as? Float {
            toRotation = CGFloat(rotationInFloat)
        } else if let rInCGFloat = params["rotation"] as? CGFloat {
            toRotation = rInCGFloat
        }
        
        super.init()
        
        originX = target.position.x
        originY = target.position.y
        originWidth = target.contentSize.width
        originHeight = target.contentSize.height
        originScaleX = CGFloat(target.scaleX)
        originScaleY = CGFloat(target.scaleY)
        originRotation = CGFloat(target.rotation)
        originAlpha = target.opacity
        
        //println(originRotation)
        
        setup()
    }
    
    func setup(){
        loop = CADisplayLink(target: self, selector: Selector("onLoop"))
        loop.frameInterval = 1
        loop.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    func onLoop(){
        //println("\(currentTime)")
        if ((currentTime >= delayTime && speed > 0) || (speed < 0))// && _currentTime <= _totalTime))
        {
            //var value;
            var time = Float((currentTime - delayTime) / Double(_time));
            //make this nicer!
            time = fminf(1.0, fmaxf(0.0, time));
            
            //=============================================
            //        UPDATE VALUES
            //=============================================
            
            easeNumber = Ease.getEaseNumber(easeType, time: time)
            
            var newX:CGFloat!
            var newY:CGFloat!
            var newW:CGFloat!
            var newH:CGFloat!
            var newAlpha:CGFloat!
            var newScaleX:CGFloat!
            var newScaleY:CGFloat!
            var newRotation:CGFloat!
            
            if toX != nil {
                newX = getNewValue(toX, fromValue: Float(originX), ease: easeNumber!)
            } else {
                newX = originX
            }
            
            if toY != nil {
                newY = getNewValue(toY, fromValue: Float(originY), ease: easeNumber!)
                println(newY)
            } else {
                newY = originY
            }
            
            if toWidth != nil {
                newW = getNewValue(toWidth, fromValue: Float(originWidth), ease: easeNumber!)
            } else {
                newW = originWidth
            }
            
            if toHeight != nil {
                newH = getNewValue(toHeight, fromValue: Float(originHeight), ease: easeNumber!)
            } else {
                newH = originHeight
            }
            
            if toScaleX != nil {
                newScaleX = getNewValue(toScaleX, fromValue: Float(originScaleX), ease: easeNumber!)
            } else {
                newScaleX = originScaleX
            }
            
            if toScaleY != nil {
                newScaleY = getNewValue(toScaleY, fromValue: Float(originScaleY), ease: easeNumber!)
            } else {
                newScaleY = originScaleY
            }
            
            if toRotation != nil {
                newRotation = getNewValue(toRotation, fromValue: Float(originRotation), ease: easeNumber!)
            } else {
                newRotation = originRotation
            }
            
            if toAlpha != nil {
                newAlpha = getNewValue(toAlpha, fromValue: Float(originAlpha), ease: easeNumber!)
            } else {
                newAlpha = originAlpha
            }
            
            target.position.x = newX
            target.position.y = newY
            target.rotation = Float(newRotation)
            target.scaleX = Float(newScaleX)
            target.scaleY = Float(newScaleY)
            target.contentSize.width = newH
            target.contentSize.height = newH
            target.opacity = newAlpha
            
            //=============================================
            
            if(runOnStart != nil && !isStarted){
                runOnStart?()
                isStarted = true
            }
            
            if (runOnUpdate != nil) {
                runOnUpdate?(time)
            }
            
            if (time == 1.0)
            {
                if (!isYoyo)
                {
                    if (repeat == 0 || repeatCount == repeat)
                    {
                        self.stop()
                    }
                    else
                    {
                        currentTime = 0.0;
                        repeatCount++;
                    }
                }
                else
                {
                    currentTime = totalTime;
                    speed = speed * -1;
                }
            }
            else if (time == 0 && speed < 0)
            {
                if (repeat == 0 || repeatCount == repeat)
                {
                    self.stop()
                }
                else
                {
                    currentTime = 0.0;
                    speed = speed * -1;
                    repeatCount++;
                }
            }
        }
        
        currentTime += loop.duration * speed;
    }
    
    func getNewValue(toValue:CGFloat, fromValue:Float, ease:Float)->CGFloat {
        changeValue = Float(toValue) - fromValue
        var value = fromValue + changeValue * ease;
        return CGFloat(value)
    }
    
    func start(){
        setup()
    }
    
    func pause(){
        if(!isPaused){
            loop.invalidate()
            isPaused = true;
        }
    }
    
    func resume(){
        if(isPaused){
            setup()
            isPaused = false;
        }
    }
    
    func stop(){
        //testOnComplete?()
        runOnComplete?()
        loop.invalidate()
    }
}