# SBTween
A tween framework for SpriteBuilder

Once again, an animations within SpriteBuilder is a little confuse to me, so I decide to create my own animation framework.

**Here is how it should be used:**

```
// object is a CCNode
SBTween.to(object, time: 1, params: ["x": 100, "y": 100, "ease": Quint.easeOut])
```

Tween with delay: 

```
// object is a CCNode
// tween will start after 2 seconds
SBTween.to(object, time: 1, params: ["x": 100, "y": 100, "ease": Quint.easeOut, "delay": 2])
```

And use with event callbacks:

```
// object is a CCNode
SBTween.to(object, time: 1, params: ["x": 100, "y": 100, "ease": Quint.easeOut, "delay": 2], events: ["onComplete": onTweenComplete])

// fire "Done!" when finished
func onTweenComplete(){
    println("Done!")
}
```

..even callbacks with progress:

```
// object is a CCNode
SBTween.to(object, time: 1, params: ["x": 100, "y": 100, "ease": Quint.easeOut, "delay": 2], events: ["onUpdate": onTweenUpdate])

// fire 0 -> 1 as progressing
func onTweenUpdate(progress:Float){
    println(progress)
}
```

**Now this is the list of available properties which you can tween with this framework:**

```
alpha
x
y
width
height
scaleX
scaleY
rotation
```

**Then the list of available easing types:**

```
Linear (no easing animation)
Back
Quint
Elastic
Sine 
Bounce
Expo 
Circ 
Cubic 
Quart 
Quad
```

That's it for now! 

Happy coding everyone!
