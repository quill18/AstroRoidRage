extends Node

signal SCORE_CHANGED
signal LEVEL_CHANGED
signal LIVES_CHANGED

signal GAME_OVER

var score:
		get:
			return score
		set(value):
			score = value
			SCORE_CHANGED.emit(score)
			
var level:
		get:
			return level
		set(value):
			level = value
			LEVEL_CHANGED.emit(level)
			
var lives:
		get:
			return lives
		set(value):
			lives = value
			LIVES_CHANGED.emit(lives)

var num_asteroids = 3

var player_scene = preload("res://player.tscn")
var asteroid_big_scene = preload("res://asteroid_big.tscn")

var asteroid_spawn_range_min = 100
var asteroid_spawn_range_max = 300

var player_node : Node2D = null

@onready var viewport_size = get_viewport().size

@export var asteroid_container : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_new_game()

func setup_new_game():
	cleanup_game()
	lives = 3
	score = 0
	level = 0
	setup_new_level(num_asteroids)

func cleanup_game():
	if player_node:
		player_node.queue_free()
		player_node = null
		
	# TODO: Destroy asteroids
	for ast in asteroid_container.get_children():
		ast.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_player_death():
	if lives <= 0:
		game_over()
		return
	
	lives -= 1
	spawn_player()
	pass

func game_over():
	if player_node:
		player_node.queue_free()
		player_node = null
		
	GAME_OVER.emit()

func setup_new_level(num_ast):
	level += 1
	
	spawn_player()
	
	for i in num_ast:
		spawn_asteroid()

func spawn_player():
	if player_node:
		player_node.queue_free()
	
	player_node = player_scene.instantiate()
	player_node.position = viewport_size/2
	player_node.has_died.connect(_on_player_death)
	call_deferred("add_child", player_node )
	
func spawn_asteroid():
	var n = asteroid_big_scene.instantiate()
	n.position = viewport_size/2.0 + (Utility.RandomUnitVector2() * randf_range( asteroid_spawn_range_min, asteroid_spawn_range_max ) )
	asteroid_container.call_deferred("add_child", n )

func add_to_score( n ):
	score += n


