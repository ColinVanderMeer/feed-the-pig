extends Node2D

export(PackedScene) var FOOD

func _on_SpawnTimer_timeout():
	var new_food = FOOD.instance()
	new_food.position = $SpawnPosition.global_position
	new_food.pig_target = $Pig.global_position
	new_food.trash_target = $Trash.global_position
	new_food.FALL_SPEED = 5 + ScoreManager.score / 22
	add_child(new_food)

func _process(delta):
	$SpawnTimer.wait_time = 1 - log(ScoreManager.score) / 30
