extends CharacterBody2D
@export var bullet : PackedScene = load("res://scenes/bullet.tscn")
@onready var body = $Body
@onready var legs = $Legs
@onready var spawners_controller = $"../spawners_controller"


const SPEED = 85
@onready var timer = get_node("AttackSpeedTimer")
var attack_speed = 0.5
var can_shoot = true
var vector = Vector2(0,0)

func _ready():
	timer.set_wait_time(attack_speed)
	timer.timeout.connect(gun_cooldown)

#gun cooldown
func gun_cooldown():
	can_shoot = true

func _physics_process(_delta):

#horizontal movement
	var direction_h = Input.get_axis("MoveLeft", "MoveRight")
	if direction_h:
		velocity.x = direction_h * SPEED
		legs.play("walk")
		if velocity.x > 1:
			body.play("right")
		else:
			body.play("left")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

#vertical movement
	var direction_v = Input.get_axis("MoveUp", "MoveDown")
	if direction_v:
		velocity.y = direction_v * SPEED
		legs.play("walk")
		if velocity.y > 1:
			body.play("down")
		else:
			body.play("up")
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
#reset movement animation
	if velocity.x == 0 && velocity.y == 0:
		body.play("idle")
		legs.play("idle")
		
#Shooting input detection
	if (Input.is_action_pressed("ShootUp") && Input.is_action_pressed("ShootLeft")) && can_shoot:
		vector.x = -1
		vector.y = -1
		shoot()
	if (Input.is_action_pressed("ShootUp") && Input.is_action_pressed("ShootRight")) && can_shoot:
		vector.x = 1
		vector.y = -1
		shoot()
	if (Input.is_action_pressed("ShootDown") && Input.is_action_pressed("ShootLeft")) && can_shoot:
		vector.x = -1
		vector.y = 1
		shoot()
	if (Input.is_action_pressed("ShootDown") && Input.is_action_pressed("ShootRight")) && can_shoot:
		vector.x = 1
		vector.y = 1
		shoot()

	if (Input.is_action_pressed("ShootUp")) && can_shoot:
		vector.y = -1
		shoot()
	if (Input.is_action_pressed("ShootDown")) && can_shoot:
		vector.y = 1
		shoot()
	if (Input.is_action_pressed("ShootLeft")) && can_shoot:
		vector.x = -1
		shoot()
	if (Input.is_action_pressed("ShootRight")) && can_shoot:
		vector.x = 1
		shoot()

	move_and_slide()

#creating projectile instances
func shoot():
	var b = bullet.instantiate()
	owner.add_child(b)
	b.transform = $Muzzle.global_transform
	b.velocity.x = vector.x
	b.velocity.y = vector.y
	can_shoot = false
	timer.start()
	vector.x = 0
	vector.y = 0

#mob detection
func _on_area_2d_area_entered(area):
	if area.is_in_group("mobs"):
		queue_free()
		spawners_controller.stop()
