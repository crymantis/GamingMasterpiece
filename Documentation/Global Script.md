---
obsidianUIMode: preview
---
A global script is one that is autoloaded at the beginning of your games boot, it can be used to store references to other Nodes that can be accessed globally by your other scripts!

For example... Our global script can hold a reference to our main scene, that way we never have to traverse up the scene tree, we can simply access it from `Global.main_scene`.

**Here's how to set that up:**
1. Create a new script called `Global.gd` (doesn't have to have this name just an example)
2. Navigate to *Project > Project Settings > Autoload (tab)*
   ![[Pasted image 20240217135525.png]]
   3. Add your `Global.gd` to Autoload
  ![[Pasted image 20240217135703.png]]

**Now, if we want to globally store a reference to the main scene:**
1. Create a variable in your `Global` script to hold it
   ![[Pasted image 20240217140012.png]]
   2. Save a reference of `self` from the main scene's script in the global variable
![[Pasted image 20240217140211.png]]

Now, when the main scene gets loaded it will trigger the `_ready()` function, which will set the `Global.main_scene` variable to a reference of itself.

This means from any other script in the game we can now access `Global.main_scene`. 