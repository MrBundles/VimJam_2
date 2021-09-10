tool
extends Line2D

# references ------------------------------------------------------------------


# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------
export(float, 0, 10) var point_radius
export(Color) var point_color
export(float, 0, 10) var line_width
export(Color) var line_color

var segment_lengths = []
export(int) var max_iterations = 100
export(float) var min_acceptable_distance = .01


# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	
	
	# initialize
	init_segment_lengths()


func _process(delta):
	update()
	fabric_update()


func _draw():
	# do not try to draw line if there are no points
	if points.size() < 1:
		return
	
	var previous_point = points[0]
	for point in points:
		draw_circle(point, point_radius, point_color)
		
		# draw a line segment between each point
		if point != previous_point:
			draw_line(point, previous_point, line_color, line_width)
		
		previous_point = point


func _get_configuration_warning():
	if 0:
		return "Configuration Warning String"
	else:
		return ""


# helper functions ------------------------------------------------------------
func init_segment_lengths():
	# do not try to draw line if there are no points
	if points.size() < 1:
		return
	
	var origin = points[0]
	var previous_point = origin
	for point in points:
		if point != origin:
			segment_lengths.append(point.distance_to(previous_point))
			previous_point = point
	
	print(segment_lengths)
	
	
func fabric_update():
	pass


# set/get functions -----------------------------------------------------------



# signal functions ------------------------------------------------------------


