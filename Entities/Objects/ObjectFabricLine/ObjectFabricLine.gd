extends Line2D

# references ------------------------------------------------------------------


# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------
export(float, 0, 10) var point_radius
export(Color) var point_color
export(float, 0, 10) var line_width
export(Color) var line_color

var segment_lengths = []
var target = Vector2.ZERO
export var arm_lerp_val = .3
export var arm_target_multiplier = Vector2(1,1)
export(int) var max_iterations = 100
export(float) var min_acceptable_distance = .01


# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	
	
	# initialize
	init_segment_lengths()


func _process(delta):
	get_input()
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
#	draw_circle(get_global_mouse_position(), point_radius, point_color)


func _get_configuration_warning():
	if 0:
		return "Configuration Warning String"
	else:
		return ""


# helper functions ------------------------------------------------------------
func get_input():
	if Input.is_action_just_pressed("fabric_update"):
		fabric_update()


func init_segment_lengths():
	# do not try to draw line if there are no points
	if points.size() < 1:
		return
	
	var origin = points[0]
	var previous_point = origin
	for point in points:
		if point != origin:
			segment_lengths.append(previous_point.distance_to(point))
			previous_point = point
	
	
func fabric_update():
	# do not try to process points if there are no points
	if points.size() < 1:
		return
	
	var origin = points[0]
	target.x = lerp(points[points.size()-1].x, -get_parent().velocity.x * arm_target_multiplier.x, arm_lerp_val)
	target.y = lerp(points[points.size()-1].y, -get_parent().velocity.y * arm_target_multiplier.y, arm_lerp_val)
	print(target)
	
	for iteration in range(max_iterations):
		var starting_from_origin = iteration % 2 == 1
		invert_points()
		segment_lengths.invert()
		
		if starting_from_origin:
			points[0] = origin
		else:
			points[0] = target
		
		for i in range(1, points.size()):
			var direction = points[i-1].direction_to(points[i])
			set_point_position(i, points[i-1] + direction * segment_lengths[i-1])
		
		if starting_from_origin and points[points.size() - 1].distance_to(target) < min_acceptable_distance:
			return


func invert_points():
	var points_copy = []
	for point in points:
		points_copy.append(point)
	points_copy.invert()
	set_points(points_copy)


# set/get functions -----------------------------------------------------------



# signal functions ------------------------------------------------------------


