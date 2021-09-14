extends FabricLine

# references ------------------------------------------------------------------


# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------
export var leg_lerp_val = Vector2(.1,.1)

var current_step_position = Vector2.ZERO
export var step_distance = 32.0

export var leg_is_lead = true
export(float, 45, 135) var init_raycast_rotation_degrees setget set_init_raycast_rotation_degrees


# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	GSM.connect("change_lead_leg", self, "_on_change_lead_leg")
	
	# initialize setgets
	self.init_raycast_rotation_degrees = init_raycast_rotation_degrees
	
	$RayCast2D.add_exception(get_parent())
	$RayCast2D.force_raycast_update()
	$RayCast2D.cast_to = Vector2(-position.y / sin(45) * 1.25, 0)


func _process(delta):
	update()
	pass


func _physics_process(delta):
	update_target_position(delta)


#func _draw():
#	draw_circle(target_position, 10.0, Color(1,1,1,1))
#	draw_circle($RayCast2D.get_collision_point() - get_parent().global_position - position, 10.0, Color(1,1,0,1))
#	draw_circle(current_step_position - get_parent().global_position - position, 10.0, Color(1,0,0,1))


func _get_configuration_warning():
	if 0:
		return "Configuration Warning String"
	else:
		return ""


# helper functions ------------------------------------------------------------
func update_target_position(delta):
	$RayCast2D.rotation_degrees = lerp($RayCast2D.rotation_degrees, lerp(90, 45, current_origin_velocity.x / max_origin_velocity.x), .1)
	
	if leg_is_lead and current_step_position.distance_to($RayCast2D.get_collision_point()) > abs(current_step_position.x - get_parent().global_position.x - position.x) * 10 or current_step_position.distance_to($RayCast2D.get_collision_point()) > step_distance:
		GSM.emit_signal("change_lead_leg")
		
#	if abs(current_origin_velocity.x) < 1:
#		current_step_position = lerp(current_step_position, $RayCast2D.get_collision_point(), .1)
		
	target_position.x = lerp(target_position.x, current_step_position.x - get_parent().global_position.x - position.x, leg_lerp_val.x)
	target_position.y = lerp(target_position.y, current_step_position.y - get_parent().global_position.y - position.y, leg_lerp_val.y)


# set/get functions -----------------------------------------------------------
func set_init_raycast_rotation_degrees(new_val):
	init_raycast_rotation_degrees = new_val
	
	if has_node("RayCast2D"):
		$RayCast2D.rotation_degrees = init_raycast_rotation_degrees


# signal functions ------------------------------------------------------------
func _on_change_lead_leg():
	leg_is_lead = !leg_is_lead
	if leg_is_lead:
		current_step_position = $RayCast2D.get_collision_point()

