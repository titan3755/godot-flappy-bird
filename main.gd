extends Node2D

@export var obstacle_scene:PackedScene
@export var wall_gap:int
@export var wall_fundamental_gap:int = 50
@export var start_position_vertical:int
var score
var screen_size
var game_state

# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0
	screen_size = get_viewport_rect().size
	game_state = false
	$Player.hide()
	$HUD.hide_show(0, true)
	$HUD.hide_show(1, false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("start_game") && game_state == false:
		new_game(game_state)

func _on_wall_spawn_timer_timeout():
	score += 1
	$HUD.update_score("Score: " + str(score))
	var top_wall = obstacle_scene.instantiate()
	var bottom_wall = obstacle_scene.instantiate()
	wall_y_determiner(top_wall, bottom_wall, wall_gap, screen_size)
	add_child(top_wall)
	add_child(bottom_wall)

func wall_y_determiner(top_wall, bottom_wall, wall_gp, screen_sz):
	var randomizer = randi_range(-150, 150)
	var top_wall_y = (-(screen_sz.y / 2) + randomizer)
	var bottom_wall_y = -top_wall_y + wall_gp + randomizer + wall_fundamental_gap
	top_wall.position.y = top_wall_y
	bottom_wall.position.y = bottom_wall_y

func new_game(game_st):
	$WallSpawnTimer.start()
	$Player.show()
	$Player.position.y = start_position_vertical
	$Player.velocity.y = 0
	$HUD.hide_show(0, false)
	$HUD.hide_show(1, true)
	game_st = true
