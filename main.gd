extends Node

var num_asteroids = 3

var player_scene = preload("res://player.tscn")
var asteroid_big_scene = preload("res://asteroid_big.tscn")

var asteroid_spawn_range_min = 100
var asteroid_spawn_range_max = 300

var player_node = null

@onready var viewport_size = get_viewport().size

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_new_level(num_asteroids)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_player_death():
	spawn_player()
	pass

func setup_new_level(num_ast):
	spawn_player()
	
	for i in num_ast:
		spawn_asteroid()
		
func spawn_player():
	if player_node:
		player_node.queue_free()
	
	player_node = player_scene.instantiate()
	player_node.position = viewport_size/2
	player_node.has_died.connect(_on_player_death)
	add_child( player_node )
	
func spawn_asteroid():
	var n = asteroid_big_scene.instantiate()
	n.position = viewport_size/2.0 + (Utility.RandomUnitVector2() * randf_range( asteroid_spawn_range_min, asteroid_spawn_range_max ) )
	add_child( n )	


	
