extends Line2D
class_name FabricLine

# references ------------------------------------------------------------------


# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------
# variables for fabric line visuals, may remove
#export(float, 0, 10) var point_radius
#export(Color) var point_color
#export(float, 0, 10) var line_width
#export(Color) var line_color

# variables for generating the fabric line points
export var point_count = 5
export var point_spread = 20

# segment length variables used in fabric calculations
var segment_lengths = []
var segment_length_sum = 0.0

# this is the point the fabric line is reaching for. All scripts inheriting this FabricLine class can animate this line by manipulating this value
var target_position = Vector2.ZERO

# variables used in fabric calculations
export(int) var max_iterations = 100
export(float) var min_acceptable_distance = .01

# variables used to calculate current origin velocity
var current_origin_position = Vector2.ZERO
var previous_origin_position = Vector2.ZERO
var current_origin_velocity = Vector2.ZERO
var max_origin_velocity = Vector2(1,1)


# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	
	
	# initialize segets
	self.point_count = point_count
	self.point_spread = point_spread
	
	init_points()
	init_segment_lengths()
	
	# reset the max_origin_velocity to account for initial settline of the points, otherwise this value could be huge upon initial loading of the scene
	yield(get_tree().create_timer(1.0), "timeout")
	max_origin_velocity = Vector2(1,1)
	


func _process(delta):
	current_origin_velocity_update(delta)
	fabric_update()
#	update()


#func _draw():
#	# do not try to draw line if there are no points
#	if points.size() < 1:
#		return
#
#	var previous_point = points[0]
#	for point in points:
#		# draw each point
#		draw_circle(point, point_radius, point_color)
#
#		# draw a line segment between each point
#		if point != previous_point:
#			draw_line(point, previous_point, line_color, line_width)
#
#		previous_point = point

	# draw target position, currently the global mouse position
#	draw_circle(target_position, point_radius * 2.0, point_color)


func _get_configuration_warning():
	if 0:
		return "Configuration Warning String"
	else:
		return ""


# helper functions ------------------------------------------------------------
func init_points():
	points.empty()
	for i in range(point_count):
		add_point(Vector2(i * point_spread, 0), i)


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


func current_origin_velocity_update(delta):
# calculate current velocity of the origin of the line
	current_origin_position = points[0] + get_parent().global_position
	current_origin_velocity = (current_origin_position - previous_origin_position) / delta
	previous_origin_position = current_origin_position
	
	if abs(current_origin_velocity.x) > max_origin_velocity.x:
		max_origin_velocity.x = abs(current_origin_velocity.x)
	
	if abs(current_origin_velocity.y) > max_origin_velocity.y:
		max_origin_velocity.y = abs(current_origin_velocity.y)


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


# signal functions ------------------------------------------------------------


