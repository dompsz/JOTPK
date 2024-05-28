extends Node2D

@onready var timer = $respawn_timer
@onready var s1 = $"../spawners/spawner"
@onready var s2 = $"../spawners/spawner2"
@onready var s3 = $"../spawners/spawner3"
@onready var s4 = $"../spawners/spawner4"
@onready var s5 = $"../spawners/spawner5"
@onready var s6 = $"../spawners/spawner6"
@onready var s7 = $"../spawners/spawner7"
@onready var s8 = $"../spawners/spawner8"
@onready var s9 = $"../spawners/spawner9"
@onready var s10 = $"../spawners/spawner10"
@onready var s11 = $"../spawners/spawner11"
@onready var s12 = $"../spawners/spawner12"
@onready var main = $".."

var timer_cooldown = 2.5
var timer_min = 0.7
var timer_decrease_speed = 0.05

func _ready():
#timer setup
	timer.set_wait_time(timer_cooldown)
	timer.start()
	timer.timeout.connect(spawn)

#choose a random spawner to activate
func spawn():
	var rng = randi_range(1, 12)
	
	match rng:
		1:s1.spawn()
		2:s2.spawn()
		3:s3.spawn()
		4:s4.spawn()
		5:s5.spawn()
		6:s6.spawn()
		7:s7.spawn()
		8:s8.spawn()
		9:s9.spawn()
		10:s10.spawn()
		11:s11.spawn()
		12:s12.spawn()
		
	#timer speed up
	if timer_cooldown > timer_min:
		timer_cooldown -= timer_decrease_speed
		timer.set_wait_time(timer_cooldown)
	timer.start()
	
func stop():
	timer.stop()
	main.death()
	
