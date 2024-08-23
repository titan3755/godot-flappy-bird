extends StaticBody2D

@export var wall_movement_velocity:int
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	position.x = screen_size.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (position.x < 0 - 200):
		queue_free()
	position.x -= delta * wall_movement_velocity
	
