extends FabricLine

# references ------------------------------------------------------------------


# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------
export var head_lerp_val = Vector2(.1,.1)

var mouse_target = Vector2.ZERO
export var max_mouse_target_distance = 100
var normal_target = Vector2.ZERO
export var normal_target_lerp_val = Vector2(.1,.1)
export var normal_target_multiplier = Vector2(1,1)
export var clamp_limit_multiplier = Vector2(1.0,1.0)

var force_head_to_target = false
var hide_available = false
var hide_position = Vector2.ZERO
var hiding = false setget set_hiding

# draw variables
export var eye_radius = 5.0
export(Color) var eye_color = Color(1,1,1,1)
export var pupil_radius = 2.0
export(Color) var pupil_color = Color(1,1,1,1)
export var head_radius = 10.0
export(Color) var head_color
export var beak_length = 16.0
export var beak_width = 8.0
export(Color) var beak_color = Color(1,1,1,1)


# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	
	
	# initialize setgets
	self.hiding = hiding


func _process(delta):
	get_input()
	update_target_position(delta)
	update_raycast()
	update()


func _draw():
	# don't try to draw the head with less than two points in the line
	if points.size() < 2:
		return
	
	# don't draw the head if the character is hiding
	if not hiding:
		# draw beak
		var last_point = points[points.size()-1]
		var second_to_last_point = points[points.size() - 2]
		var beak_endpoint = last_point + (last_point - second_to_last_point).normalized() * beak_length
		draw_line(last_point, beak_endpoint, beak_color, beak_width)
		draw_circle(beak_endpoint, beak_width / 2, beak_color)
		
		# draw head
		draw_circle(points[points.size()-1], head_radius, head_color)
		
		# draw eye
		draw_circle(points[points.size()-1], eye_radius, eye_color)
		
		# draw pupil
		draw_circle(points[points.size()-1], pupil_radius, pupil_color)
	
	# if in debug mode
	if GVM.debug_mode:
		if $RayCast2D.is_colliding():
			draw_circle($RayCast2D.get_collision_point() - get_parent().global_position - position, 5.0, Color(1,1,0,1))

func _get_configuration_warning():
	if 0:
		return "Configuration Warning String"
	else:
		return ""


# helper functions ------------------------------------------------------------
func get_input():
	if Input.is_action_pressed("mb_left"):
		force_head_to_target = true
	else:
		force_head_to_target = false
	
	if Input.is_action_just_pressed("mb_left"):
		if hiding:
			self.hiding = false
		elif hide_available:
			self.hiding = true


func update_target_position(delta):
	if hiding:
		target_position.x = lerp(target_position.x, hide_position.x, head_lerp_val.x)
		target_position.y = lerp(target_position.y, hide_position.y, head_lerp_val.y)
	elif force_head_to_target:
		target_position.x = lerp(target_position.x, get_global_mouse_position().x - get_parent().global_position.x - position.x, head_lerp_val.x)
		target_position.y = lerp(target_position.y, get_global_mouse_position().y - get_parent().global_position.y - position.y, head_lerp_val.y)
	else:
		# set mouse target for when mouse is close to ostrich
		mouse_target = get_global_mouse_position() - get_parent().global_position - position
		
		# set normal target for when mouse is not close to ostrich
		var clamp_limit = Vector2(segment_length_sum * cos(45.0) * clamp_limit_multiplier.x, segment_length_sum * sin(45.0) * clamp_limit_multiplier.y)
		normal_target.x = clamp(lerp(normal_target.x, current_origin_velocity.x * normal_target_multiplier.x, normal_target_lerp_val.x), -clamp_limit.x, clamp_limit.x)
		normal_target.y = clamp(lerp(normal_target.y, mouse_target.y * normal_target_multiplier.y, normal_target_lerp_val.y), -clamp_limit.y, -segment_length_sum / 2)
		
		target_position.x = lerp(target_position.x, lerp(mouse_target.x, normal_target.x, clamp(current_origin_position.distance_to(get_global_mouse_position()) / max_mouse_target_distance, 0, 1)), head_lerp_val.x)
		target_position.y = lerp(target_position.y, lerp(mouse_target.y, normal_target.y, clamp(current_origin_position.distance_to(get_global_mouse_position()) / max_mouse_target_distance, 0, 1)), head_lerp_val.y)


func update_raycast():
	# don't try to update the raycast position and angle with less than two points in the line
	if points.size() < 2:
		return
	
	var last_point = points[points.size()-1]
	var second_to_last_point = points[points.size() - 2]
	$RayCast2D.cast_to = (last_point - second_to_last_point).normalized() * 16
	$RayCast2D.position = points[points.size()-1]
	
	hide_available =  $RayCast2D.is_colliding() and $RayCast2D.get_collider().is_in_group("tilemap")


# set/get functions -----------------------------------------------------------
func set_hiding(new_val):
	hiding = new_val
	GSM.emit_signal("set_hiding", hiding)
	
	if hiding:
		hide_position = $RayCast2D.get_collision_point() - get_parent().global_position - position


# signal functions ------------------------------------------------------------


