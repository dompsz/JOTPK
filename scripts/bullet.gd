extends CharacterBody2D

var speed = 200
var direction = Vector2.ZERO

func _physics_process(delta):
	#shoot
	var _collision_info = move_and_collide(velocity.normalized() 
	* speed * delta)
	
func _on_area_2d_area_entered(area):
	if area.is_in_group("mobs"):
		queue_free()	
	
#delete bullets out of screen
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
