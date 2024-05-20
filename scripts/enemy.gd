extends CharacterBody2D
@export var player : PackedScene = load("res://scenes/player.tscn")

var motion = Vector2(0, 0)
const speed = 75

func _physics_process(delta):
	# Add the gravity.
	#motion = position.direction_to(player.position2d) * speed
	motion = move_and_slide()#motion)
	
