extends Node2D
@onready var high_score_label = $HighScoreLabel
@onready var score_label = $ScoreLabel

var save_data:SaveData
var score:int = 0
var game_over = false

func _ready():
	save_data = SaveData.load_or_create()
	high_score_label.text = "High Score: " + str(save_data.high_score)
	get_tree().paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if game_over == false:
		if Input.is_action_just_pressed("Start") && get_tree().paused == true :
			play()

func play():
	get_tree().paused = false
	game_over = false

func death():
	game_over = true
	if save_data.high_score < score:
		save_data.high_score = score
		high_score_label.text = "High Score: " + str(score)
		save_data.save()

func add_score():
	score += 1
	score_label.text = "Score: " + str(score)
