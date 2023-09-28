extends RigidBody2D

class_name RigidBody2DWrap

@onready var viewport_size = get_viewport().size
@onready var sprite_size = $Sprite2D.get_rect().size

func _integrate_forces(state):
	wrap_to_viewport(state)

func wrap_to_viewport(state):
	# if we are off the left side of the screen
	#    set position to right side of the screen
	if state.transform.origin.x + sprite_size.x/2 < 0:
		state.transform.origin.x = viewport_size.x + sprite_size.x/2	
	if state.transform.origin.x - sprite_size.x/2 > viewport_size.x:
		state.transform.origin.x = -sprite_size.x/2	
	if state.transform.origin.y + sprite_size.y/2 < 0:
		state.transform.origin.y = viewport_size.y + sprite_size.y/2	
	if state.transform.origin.y - sprite_size.y/2 > viewport_size.y:
		state.transform.origin.y = -sprite_size.y/2
	
