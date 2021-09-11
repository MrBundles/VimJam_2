extends Line2D

# references ------------------------------------------------------------------


# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------
export(float, 0, 10) var point_radius
export(Color) var point_color
export(float, 0, 10) var line_width
export(Color) var line_color

export var point_count = 5 setget set_point_count
export var point_spread = 20 setget set_point_spread
var segment_lengths = []
var segment_length_sum = 0.0
var target_position = Vector2.ZERO
var target_y_offset = 0
export var arm_flap_multiplier = 1.0
export var arm_flap_sin = true
export var target_gravity = 5.0
export var arm_lerp_val = Vector2(.3,.3)
export var arm_target_multiplier = Vector2(1,1)
export(int) var max_iterations = 100
export(float) var min_acceptable_distance = .01

var current_origin_position = Vector2.ZERO
var previous_origin_position = Vector2.ZERO
var current_origin_velocity = 0.0


# RNG
var rng = RandomNumberGenerator.new()
var random_offset_val = rng.randf_range(-1000, 1000)


# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	
	
	# initialize segets
	self.point_count = point_count
	self.point_spread = point_spread
	
	init_points()
	init_segment_lengths()
	


func _process(delta):
	get_input()
	update_target_position(delta)
	fabric_update()
	update()


func _draw():
	# do not try to draw line if there are no points
	if points.size() < 1:
		return
	
	var previous_point = points[0]
	for point in points:
		# draw each point
		draw_circle(point, point_radius, point_color)
		
		# draw a line segment between each point
		if point != previous_point:
			draw_line(point, previous_point, line_color, line_width)
		
		previous_point = point
	
	# draw target position, currently the global mouse position
#	draw_circle(target_position, point_radius * 2.0, point_color)


func _get_configuration_warning():
	if 0:
		return "Configuration Warning String"
	else:
		return ""


# helper functions ------------------------------------------------------------
func get_input():
	if Input.is_action_just_pressed("fabric_update"):
		fabric_update()


func init_points():
	points.empty()
	for i in range(point_count):
		add_point(Vector2(i * point_spread, 0), i)


func update_target_position(delta):
	
	current_origin_position = points[0] + get_parent().global_position
	current_origin_velocity = (current_origin_position - previous_origin_position) / delta
#	print("Current Velocity: " + str(current_origin_velocity))
	previous_origin_position = current_origin_position
	
	#add gravity to target_position.y
	target_position.y += target_gravity * (segment_length_sum / clamp(abs(target_position.x), 1, 1000))
	
	#influence target_position.y to create wavy motion
	if arm_flap_sin:
		target_position.y += sin((current_origin_position.x) / 15) * arm_flap_multiplier * (abs(target_position.x) / segment_length_sum)
	else:
		target_position.y += cos((current_origin_position.x) / 15) * arm_flap_multiplier * (abs(target_position.x) / segment_length_sum)
	
	target_position.x = clamp(lerp(target_position.x, -current_origin_velocity.x * arm_target_multiplier.x, arm_lerp_val.x), -segment_length_sum, segment_length_sum)
	target_position.y = clamp(lerp(target_position.y, -current_origin_velocity.y * arm_target_multiplier.y, arm_lerp_val.y), -segment_length_sum, segment_length_sum)
	
#	target_y_offset = lerp(target_y_offset, rng.randf_range(-32, 32), .5)
#	target_position.x = lerp(target_position.x, -current_origin_velocity * arm_target_multiplier.x, arm_lerp_val)
#	target_position.y = lerp(target_position.y, -get_parent().velocity.y * arm_target_multiplier.y + target_y_offset, arm_lerp_val)


func init_segment_lengths():
	# do not try to draw line if there are no points
	if points.size() < 1:
		return
	
	segment_lengths.empty()
	
	var origin = points[0]
	var previous_point = origin
	for point in points:
		if point != origin:
			var segment_length = previous_point.distance_to(point)
			segment_lengths.append(segment_length)
			segment_length_sum += segment_length
			previous_point = point
	
#	segment_length_sum *= .8
	
	
func fabric_update():
	# do not try to process points if there are no points
	if points.size() < 1:
		return
	
	var origin = points[0]	
	for iteration in range(max_iterations):
		var starting_from_origin = iteration % 2 == 1
		invert_points()
		segment_lengths.invert()
		
		if starting_from_origin:
			points[0] = origin
		else:
			points[0] = target_position
		
		for i in range(1, points.size()):
			var direction = points[i-1].direction_to(points[i])
			set_point_position(i, points[i-1] + direction * segment_lengths[i-1])
		
		if starting_from_origin and points[points.size() - 1].distance_to(target_position) < min_acceptable_distance:
			return


func invert_points():
	var points_copy = []
	for point in points:
		points_copy.append(point)
	points_copy.invert()
	set_points(points_copy)


# set/get functions -----------------------------------------------------------
func set_point_count(new_val):
	point_count = new_val
#	init_points()
#	init_segment_lengths()


func set_point_spread(new_val):
	point_spread = new_val
#	init_points()
#	init_segment_lengths()


# signal functions ------------------------------------------------------------


