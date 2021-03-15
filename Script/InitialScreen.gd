extends Node2D

var random = RandomNumberGenerator.new()

var normalVolume

func _ready():
	random.randomize()
	var random_choice = random.randi_range(1, 3)
	$background.texture = load("res://Assests/Background/background"+ str(random_choice) +".jpg" )
	$ScorePainel/HighScoreLabel.text = str(Global.highScore)
	normalVolume = $MusicPlayerInit.volume_db

func _process(delta):
	if(not $VideoPlayer.is_playing()):
		$VideoPlayer.play()
	if($MusicControl.is_pressed() == false):
		$MusicPlayerInit.volume_db = -80
	else:
		$MusicPlayerInit.volume_db = normalVolume
	#if(not $MusicPlayerInit.is_playing()):
		
	
func _on_btn_newgame_pressed():
	 get_tree().change_scene("res://Scenes/GameScreen.tscn")


func _on_Button3_pressed():
	get_tree().change_scene("res://Scenes/Credits.tscn")
