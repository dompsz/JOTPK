extends CharacterBody2D
@export var bullet : PackedScene = load("res://scenes/bullet.tscn")
var mainScene = load("res://scenes/main.tscn")

const SPEED = 100.0
@onready var timer = get_node("AttackSpeedTimer")
var attack_speed = 0.3
var can_shoot = true
var vector = Vector2(0,0)

func _ready():
	timer.set_wait_time(attack_speed)
	#timer.set_one_shot(true)
	timer.timeout.connect(gun_cooldown)
	#add_child(timer)

#gun cooldown
func gun_cooldown():
	can_shoot = true

func _physics_process(delta):

#horizontal movement
	var direction_h = Input.get_axis("MoveLeft", "MoveRight")
	if direction_h:
		velocity.x = direction_h * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

#vertical movement
	var direction_v = Input.get_axis("MoveUp", "MoveDown")
	if direction_v:
		velocity.y = direction_v * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

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
