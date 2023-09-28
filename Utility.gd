
class_name Utility

static func RandomUnitVector2( ):
	var v = Vector2()
	v.x = randf_range( -1.0, 1.0 )
	v.y = randf_range( -1.0, 1.0 )
	return v.normalized()
