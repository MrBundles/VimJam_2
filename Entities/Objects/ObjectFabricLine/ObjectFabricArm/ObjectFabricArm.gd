extends FabricLine

# references ------------------------------------------------------------------


# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------
export var arm_flap_multiplier = 1.0
export(GVM.DIRECTION) var direction = GVM.DIRECTION.left
export var target_gravity = 5.0
export var arm_lerp_val = Vector2(.3,.3)
export var arm_target_multiplier = Vector2(1,1)


# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	
	
	# initialize setgets
	pass


func _process(delta):
	update_target_position(delta)


func _get_configuration_warning():
	if 0:
		return "Configuration Warning String"
	else:
		return ""


# helper functions ------------------------------------------------------------
func update_target_position(delta):
	#add gravity to target_position.y, gravity increases as horizontal
	target_position.y += target_gravity * (segment_length_sum / clamp(abs(current_origin_velocity.x), 1, 1000))
	
	#influence target_position.y to create wavy motion
	match direction:
		GVM.DIRECTION.up:
			pass
		GVM.DIRECTION.down:
			pass
		GVM.DIRECTION.left:
			target_position.y += sin((get_parent().global_position.x) / 20) * arm_flap_multiplier * (abs(current_origin_velocity.x) / segment_length_sum)
		GVM.DIRECTION.right:
			target_position.y += cos((get_parent().global_position.x) / 20) * arm_flap_multiplier * (abs(current_origin_velocity.x) / segment_length_sum)

	target_position.x = clamp(lerp(target_position.x, -current_origin_velocity.x * arm_target_multiplier.x, arm_lerp_val.x), -segment_length_sum, segment_length_sum)
	target_position.y = clamp(lerp(target_position.y, -current_origin_velocity.y * arm_target_multiplier.y, arm_lerp_val.y), -segment_length_sum, segment_length_sum)


# set/get functions -----------------------------------------------------------



# signal functions ------------------------------------------------------------


