extends RigidBody2DWrap

signal has_died

var rotation_speed = TAU
var thrust_force = 400

var fire_cooldown = 0.25
var fire_cooldown_remaining = 0

var invulnerability_duration = 2.0
var invulnerability_remaining = invulnerability_duration

const bullet_scene = preload("res://bullet.tscn")

@onready var my_sprite = $Sprite2D

# Called every VISUAL frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if invulnerability_remaining > 0:
		invulnerability_remaining -= delta
		if invulnerability_remaining > 0:
			do_invulnerable_visual()
		else:
			stop_invulnerable_visual()
	
	angular_velocity = 0
	if Input.is_action_pressed("rotate_cw"):
		angular_velocity = rotation_speed
	if Input.is_action_pressed("rotate_ccw"):
		angular_velocity = -rotation_speed
	if Input.is_action_pressed("thrust_forward"):
		apply_force( Vector2.UP.rotated( rotation )  * thrust_force )
		
	fire_cooldown_remaining -= delta
	if fire_cooldown_remaining <= 0 && Input.is_action_pressed("fire"):
		fire_cooldown_remaining = fire_cooldown
		do_shoot_bullet()
		
func do_invulnerable_visual():
	my_sprite.modulate.a = sin(invulnerability_remaining * 50.0) / 4.0 + 0.50
	
func stop_invulnerable_visual():
	my_sprite.modulate.a = 1
		
func do_shoot_bullet():
	var b = bullet_scene.instantiate()
	b.rotation = rotation
	b.position = $BulletSpawnSpot.global_position
	get_parent().add_child(b)
		
func _on_body_entered(body):
	if invulnerability_remaining > 0:
		return
		
	if(body.was_shoot):
		body.was_shoot.emit()
	
	has_died.emit()

	
