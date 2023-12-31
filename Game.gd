extends Node2D

export(PackedScene) var FOOD
export(int) var BGSIZE

func _ready():
	$UI/AudioStreamPlayer.play(0)

	Global.good_food = []
	Global.bad_food = []
	Global.game_over = []

	match Global.soundpack:
		"Default":
			Global.good_food.append(load("res://assets/sfx/default/good_food.wav"))
			Global.bad_food.append(load("res://assets/sfx/default/good_food.wav"))
			Global.game_over.append(load("res://assets/sfx/default/good_food.wav"))
		"Penny":
			Global.good_food.append(load("res://assets/sfx/penny/good_food_1.wav"))
			Global.good_food.append(load("res://assets/sfx/penny/good_food_2.wav"))
			Global.good_food.append(load("res://assets/sfx/penny/good_food_3.wav"))
			Global.bad_food.append(load("res://assets/sfx/penny/bad_food_1.wav"))
			Global.bad_food.append(load("res://assets/sfx/penny/bad_food_2.wav"))
			Global.bad_food.append(load("res://assets/sfx/penny/bad_food_3.wav"))
			Global.bad_food.append(load("res://assets/sfx/penny/bad_food_4.wav"))
			Global.game_over.append(load("res://assets/sfx/penny/game_over_1.wav"))
			Global.game_over.append(load("res://assets/sfx/penny/game_over_2.wav"))
			Global.game_over.append(load("res://assets/sfx/penny/game_over_3.wav"))

			

func _on_SpawnTimer_timeout():
	# Spawn new food item on set spawn position, dynamically update fall speed based on score
	var new_food = FOOD.instance()
	new_food.position = $SpawnPosition.global_position
	new_food.pig_target = $Pig.global_position
	new_food.trash_target = $Trash.global_position
	new_food.FALL_SPEED = 5 + Global.score / 16 # TODO: make this better
	add_child(new_food)

func _process(_delta):
	if Global.pause:
		$SpawnTimer.paused = true
	else:
		$SpawnTimer.paused = false
		$SpawnTimer.wait_time = 1 - log(Global.score) / (16 - Global.score / 55)
		if Global.score > 600:
			$SpawnTimer.wait_time = 0.3
	$Background.position.y = get_viewport().get_visible_rect().size.y - BGSIZE

func _on_Despawn_body_entered(body):
	body.queue_free()
