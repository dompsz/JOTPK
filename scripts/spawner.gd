extends Marker2D
@export var enemy : PackedScene = load("res://scenes/enemy.tscn")
@onready var player = %Player
@onready var main = $"../.."


func spawn():
	var e = enemy.instantiate()
	e.position = self.position
	main.add_child(e)
	
