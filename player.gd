extends Area2D

signal hit

export var speed = 400  # how fast the player will move (pixels/sec)
var screen_size  # size of the game window
var target = Vector2() #Add this variable to hold the clicked position


func _ready():
	screen_size = get_viewport_rect().size
	hide()

func start(pos):
	position = pos
	target = pos # Initial target is the start position
	show()
	$CollisionShape2D.disabled = false

# Change the target whenever a touch event happens.
func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		target = event.position

func _process(delta):

	var velocity = Vector2()  # the player's movement vector
	if position.distance_to(target)>10:
		velocity = target - position

	# if Input.is_action_pressed("ui_right"):
	# 	velocity.x += 1
	# if Input.is_action_pressed("ui_left"):
	# 	velocity.x -= 1
	
	# if Input.is_action_pressed("ui_down"):
	# 	velocity.y += 1
	# if Input.is_action_pressed("ui_up"):
	# 	velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta

	# We still need to clamp the player's position here because on devices that don't
	# match your game's aspect ratio, Godot will try to maintain it as much as possible
	# by creating black borders, if necessary.
	# Without clamp(), the player would be able to move under those borders.
	position.x = clamp(position.x,0,screen_size.x)
	position.y = clamp(position.y,0,screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = 'walk'
		$AnimatedSprite.flip_v = false
		# See the note below about boolean assignment
		$AnimatedSprite.flip_h = velocity.x<0
	elif velocity.y != 0:
		
		$AnimatedSprite.animation = 'up'
		$AnimatedSprite.flip_v = velocity.y >0




func _on_Player_body_entered(_body):
	hide()
	emit_signal('hit')
	$CollisionShape2D.set_deferred('disabled',true)
