extends RigidBody2D

export var min_speed = 150 # Minimum speed range
export var max_speed = 250 # Maximum speed range

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	
