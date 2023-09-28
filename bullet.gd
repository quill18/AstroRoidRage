extends Area2D

const SPEED = 400
var lifespan = 5.0

# Called every PHYSICS frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	lifespan -= delta
	if lifespan <= 0:
		queue_free()
		return
		
	translate( Vector2.UP.rotated(rotation) * SPEED * delta )

# Called when the body_entered signal is emitted
func _on_body_entered(body):
	if body.was_shoot:
		body.was_shoot.emit()
		queue_free()
	
