extends RigidBody2DWrap

signal was_shoot

const STARTING_FORCE = 100
const STARTING_ROTATION = PI

@export var debris_scene : PackedScene
@export var debris_amount = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	apply_impulse( Utility.RandomUnitVector2() * randf_range( STARTING_FORCE/2.0, STARTING_FORCE*2.0 ) )
	angular_velocity = randf_range( -STARTING_ROTATION, STARTING_ROTATION )

func _on_was_shoot():
	if debris_scene:
		for i in debris_amount:
			var d = debris_scene.instantiate()
			d.global_position = global_position
			get_parent().add_child(d)
	queue_free()
