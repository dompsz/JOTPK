extends CharacterBody2D
@onready var player = $"../Player"
@onready var sprite_2d = $EnemySprite
@onready var collision_shape_2d = $Collision
@onready var area_2d = $Area2D
@onready var timer = $Timer

var alive : bool = true
const speed = 75
var vector := Vector2(128, 128)

func _physics_process(_delta):
	
	#follow if alive
	if alive == true:
		#wipe enemies on player death
		if player == null:
			death_animation()
		#follow the player
		if player != null:
			vector = Vector2(int(player.position.x),int(player.position.y))
			velocity = position.direction_to(vector) * speed
		move_and_slide()
	#start death animation

#suicide and destroy bullet on contact
func _on_area_2d_area_entered(area):
	if area.is_in_group("bullet"):
		death_animation()

#start death animation and timer
func death_animation():
	alive = false
	collision_shape_2d.queue_free()
	area_2d.queue_free()
	velocity.x = 0
	velocity.y = 0
	sprite_2d.play("death")
	timer.start()
	timer.timeout.connect(suicide)
	
#suicide
func suicide():
	queue_free()
	
