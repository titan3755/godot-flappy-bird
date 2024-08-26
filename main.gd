extends Node2D

@export var obstacle_scene:PackedScene
@export var wall_gap:int
@export var wall_fundamental_gap:int = 50
@export var start_position_vertical:int
var score
var screen_size
var game_state
var game_over
var top_wall
var bottom_wall
var instances = []

# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0
	screen_size = get_viewport_rect().size
	game_state = false
	game_over = false
	$Player.hide()
	$HUD.hide_show(0, true)
	$HUD.hide_show(1, false)
	$HUD.hide_show(2, true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("start_game") && game_state == false && game_over == false:
		new_game(game_state, game_over)
	if Input.is_action_just_pressed("start_game") && game_state == false && game_over == true:
		game_over = false
		game_state = true
		new_game(game_state, game_over)
	if Input.is_action_just_pressed("exit_game") && game_state == false && game_over == true:
		get_tree().quit(0)
		
func _on_wall_spawn_timer_timeout():
	score += 1
	$HUD.update_score("Score: " + str(score))
	top_wall = obstacle_scene.instantiate()
	bottom_wall = obstacle_scene.instantiate()
	wall_y_determiner(top_wall, bottom_wall, wall_gap, screen_size)
	add_child(top_wall)
	add_child(bottom_wall)
	instances.append(top_wall)
	instances.append(bottom_wall)

func wall_y_determiner(top_wll, bottom_wll, wall_gp, screen_sz):
	var randomizer = randi_range(-150, 150)
	var top_wll_y = (-(screen_sz.y / 2) + randomizer)
	var bottom_wll_y = -top_wll_y + wall_gp + randomizer + wall_fundamental_gap
	top_wll.position.y = top_wll_y
	bottom_wll.position.y = bottom_wll_y

func new_game(_game_st, _game_ov):
	$WallSpawnTimer.start()
	$Player.game_start()
	$Player.position.y = start_position_vertical
	$Player.velocity.y = 0
	$HUD.hide_show(0, false)
	$HUD.hide_show(1, true)
	$HUD.hide_show(2, true)
	_game_st = true
	_game_ov = false

func _on_player_hit():
	$WallSpawnTimer.stop()
	$Player.hide()
	$Player.position.y = start_position_vertical
	$Player.velocity.y = 0
	$HUD.show_score_upon_gameover(score)
	$HUD.hide_show(2, false)
	$HUD.hide_show(1, true)
	$HUD.hide_show(0, true)
	for instance in instances:
		remove_child(instance)
	game_state = false
	game_over = true
	score = 0
	$HUD.update_score("Score: " + str(score))
