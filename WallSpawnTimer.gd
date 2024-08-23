extends Timer

@export var wall_spawn_frequency:int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	wait_time = wall_spawn_frequency


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
