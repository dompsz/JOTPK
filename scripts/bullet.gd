extends CharacterBody2D

var speed = 200

func _physics_process(delta):
	
	var collision_info = move_and_collide(velocity.normalized() * speed * delta)
	
func _on_Bullet_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()
	
	
