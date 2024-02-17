---
reference:
- https://www.youtube.com/watch?v=5_3NrtkI478
- https://www.youtube.com/watch?v=LBx9NxqchKE
---

**This example covers making a impact animation after falling.**
*(This can also be applied to particle systems, but replace the signal with an `AnimationTrack` which calls `queue_free()`)*

1. Make a new scene called Dust
	   This means we can have it completely self contained and it can manage itself.
2. Give this scene an `AnimatedSprite2D`
3. Add a signal `animation_finished()`
   ![[Pasted image 20240216213217.png]]



```go
func _on_animation_finished():
	queue_free()
```

This will destroy the dust node once the animation finishes!

## Extras
**Fading Out**
1. Add an `AnimationPlayer` node as a child
![[Pasted image 20240216213626.png]]
2. Set it to autoplay and no loop
3. Add keyframe to the *Visibility > Modulate* property to lower the alpha over time