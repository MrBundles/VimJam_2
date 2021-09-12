extends FabricLine

# references ------------------------------------------------------------------


# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------
export var leg_lerp_val = Vector2(.1,.1)

var current_step_position = Vector2.ZERO
export var step_distance = 32.0


# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	
	
	# initialize setgets
	pass
	
	$RayCast2D.add_exception(get_parent())


func _process(delta):
	update_target_position(delta)
	update()


func _draw():
	draw_circle(target_position, 10.0, Color(1,1,1,1))


func _get_configuration_warning():
	if 0:
		return "Configuration Warning String"
	else:
		return ""


# helper functions ------------------------------------------------------------
func update_target_position(delta):
	$RayCast2D.rotation_degrees = lerp(-45, 45, current_origin_velocity.x / max_origin_velocity.x)
	
	if current_step_position.distance_to($RayCast2D.get_collision_point()) > step_distance:
		current_step_position = $RayCast2D.get_collision_point()
		
	target_position.x = lerp(target_position.x, current_step_position.x - get_parent().global_position.x, leg_lerp_val.x)
	target_position.y = lerp(target_position.y, current_step_position.y - get_parent().global_position.y, leg_lerp_val.y)
	print(target_position)


# set/get functions -----------------------------------------------------------



# signal functions ------------------------------------------------------------


