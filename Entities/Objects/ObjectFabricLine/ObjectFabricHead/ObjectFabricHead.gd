extends FabricLine

# references ------------------------------------------------------------------


# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------
export var head_lerp_val = Vector2(.1,.1)
export var head_target_multiplier = Vector2(1,1)


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
	# set mouse target for when mouse is close to ostrich
	var mouse_target = get_global_mouse_position() - get_parent().global_position - position
	
	# set normal target for when mouse is not close to ostrich
	var normal_target.x = lerp(normal_target.x)
	target_position.x = lerp(target_position.x, get_global_mouse_position().x - get_parent().global_position.x - position.x, head_lerp_val.x)
	target_position.y = lerp(target_position.y, get_global_mouse_position().y - get_parent().global_position.y - position.y, head_lerp_val.y)


# set/get functions -----------------------------------------------------------



# signal functions ------------------------------------------------------------


