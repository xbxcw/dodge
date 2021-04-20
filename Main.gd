extends Node
export (PackedScene) var Mob

var score


func _ready():
	randomize()
	new_game()


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()


func new_game():
	score = 0
	$Player.start($StartPostion.position)
	$StartTimer.start()


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_ScoreTimer_timeout():
	score += 1


func _on_Player_hit():
	pass
	


func _on_MobTimer_timeout():
	# Choose a random location on Path2D
	$MobPath/MobSpawnLoction.offset = randi()
	# Create a Mob instance and add it to the scene
	var mob = Mob.instance()
	add_child(mob)
	# Set the mob's direction perpendicular to th path direction
	var direction = $MobPath/MobSpawnLoction.rotation + PI / 2
	mob.position = $MobPath/MobSpawnLoction.position
	# Add some randomness to the direction
	direction += rand_range(-PI / 4, PI / 4)

	mob.rotation = direction

	# Set the velocity (speed & direction)

	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)
