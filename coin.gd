extends Area2D

var screensize = Vector2()
func pickup():
    queue_free() # node removal method to remove from tree and memory (along with children)