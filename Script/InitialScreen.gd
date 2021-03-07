extends Node2D

var random = RandomNumberGenerator.new()

func _ready():
	random.randomize()
	var random_choice = random.randi_range(1, 3)
	$background.texture = load("res://Assests/Background/background"+ str(random_choice) +".jpg" )
	$ScorePainel/HighScoreLabel.text = str(Global.highScore)

func _process(delta):
	if(not $VideoPlayer.is_playing()):
		$VideoPlayer.play()
	
func _on_btn_newgame_pressed():
	 get_tree().change_scene("res://Scenes/GameScreen.tscn")
