//
//  SBTween.swift
//  SBTween
//

import UIKit
import QuartzCore

struct SBTween {
    private static var tweenArr:[TweenObject] = []
    
    private static var linearMode:ModeLinear = ModeLinear()
    private static var backMode:ModeBack = ModeBack()
    private static var quintMode:ModeQuint = ModeQuint()
    private static var elasticMode:ModeElastic = ModeElastic()
    private static var bounceMode:ModeBounce = ModeBounce()
    private static var sineMode:ModeSine = ModeSine()
    private static var expoMode:ModeExpo = ModeExpo()
    private static var circMode:ModeCirc = ModeCirc()
    private static var cubicMode:ModeCubic = ModeCubic()
    private static var quartMode:ModeQuart = ModeQuart()
    private static var quadMode:ModeQuad = ModeQuad()
    
    /*static func set(target:AnyObject, params:Dictionary<String, Any>){
        var set = SetObject(_target: target, params:params)
    }*/
    
    static func to(target:CCNode,
        time:Float,
        params:Dictionary<String, Any>,
        events:[String: Any]=Dictionary())
    {
        var tween = TweenObject(_target: target, time: time, params:params, events:events)
        tweenArr += [tween]
    }
    
    /*static func from(target:AnyObject, dur:Float, params:Dictionary<String, AnyObject>){
        var tween = TweenObject(_target: target, time: dur, params:["x":100])
        tweenArr += [tween]
    }*/
}







