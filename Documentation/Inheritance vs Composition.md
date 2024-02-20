---
obsidianUIMode: preview
---

Inheritance and Composition both have their advantages and disadvantages, but because of the modular nature of Godot, I personally take composition for granted having mostly used object oriented languages my whole life.

![[Pasted image 20240220172851.png | center]]

## Inheritance
Inheritance is used when many objects can draw from the same parent class, for example a cat and a dog can both inherit from an animal class which will have common functions and data to promote reusability in your code.  

![[Pasted image 20240220173710.png | center]]

The issue with this arises when you find an edge case, something that might apply to your parent class but doesn't really make sense for it. Maybe a snail or something? They don't really speak.

## Composition
In the places where inheritance fails, composition steps in to lend a hand. Composition breaks an object out into generalized *components* that can be applied to many use cases. Here is an example:

![[Pasted image 20240220174901.png | center]]

In this case we have separate components that handle Health, Hitbox, and Animation. A player would make use of all of these, and so would an enemy, but what about an edge case like a resource like a tree or rock? This would have health and hitbox but no animation, it also needs to use a different type of collider since its static rather than a rigid body with physics. 

![[Pasted image 20240220180215.png | center]]


> [!NOTE] References
> [How You Can Easily Make Your Code Simpler in Godot 4](https://www.youtube.com/watch?v=74y6zWZfQKk)
