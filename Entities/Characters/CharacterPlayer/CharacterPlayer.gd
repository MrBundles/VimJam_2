extends KinematicBody2D

#signals

#references
onready var left_foot = $Feet/LeftFootPivot/LeftKnee/LeftFoot
onready var right_foot = $Feet/RightFootPivot/RightKnee/RightFoot
onready var left_walk_pos = $Feet/LeftWalkPivot/LeftWalkPosition
onready var right_walk_pos = $Feet/RightWalkPivot/RightWalkPosition
onready var left_jump_pos = $Feet/LeftJumpPosition
onready var right_jump_pos = $Feet/RightJumpPosition
onready var left_walk_pivot = $Feet/LeftWalkPivot
onready var right_walk_pivot = $Feet/RightWalkPivot

# variables --------------------------------------
var velocity = Vector2.ZERO
export var velocity_max = Vector2(10,10)
export var velocity_max_push = Vector2(10,10)
var velocity_max_init = velocity_max
export var h_accel = 10
export var h_decel = 10
export var gravity = 10
export var jump = 10
export var foot_speed_mult = 2.0

export var max_feet_lerp_val = 25.0
export var leg_color = Color(1,1,1,1)
export var leg_width = 10
export var max_lean_lerp_val = 1.0

var colliding_with_body = false
var socket_align_x = -1.0
var plugged_in = false

export(Texture) var happy_face
export(Texture) var sad_face


# main functions --------------------------------------
func _ready():
	# connect signals
	GSM.connect("socket_plugged", self, "_on_socket_plugged")
	GSM.connect("terminal_on", self, "_on_terminal_on")
	
	velocity_max_init = velocity_max


func _physics_process(delta):
	get_input()
	move_and_slide(velocity * delta * 1000, Vector2.UP, false, 4, PI/4, false)
	update_feet(delta)
	update_lean(delta)
	if socket_align_x != -1:
		socket_align(delta)


# helper functions --------------------------------------
func get_input():
	#horizontal inputs
	if Input.is_action_pressed("ui_left"):
		velocity.x = clamp(velocity.x - h_accel, -velocity_max.x, velocity_max.x)
	elif Input.is_action_pressed("ui_right"):
		velocity.x = clamp(velocity.x + h_accel, -velocity_max.x, velocity_max.x)
	elif velocity.x <= -h_decel:
		velocity.x = clamp(velocity.x + h_decel, -velocity_max.x, velocity_max.x)
	elif velocity.x >= h_decel:
		velocity.x = clamp(velocity.x - h_decel, -velocity_max.x, velocity_max.x)
	else:
		velocity.x = 0
	
	#wall/ceiling collisions
	if is_on_wall():
		velocity_max.x = velocity_max_push.x
#		velocity.x = 0
	else:
		velocity_max.x = velocity_max_init.x
	
	if is_on_ceiling():
		velocity.y = 0
	
	if is_on_floor():
		$CoyoteTimer.start()
		velocity.y = 0
	
	#vertical input
	if Input.is_action_pressed("ui_up") and not $CoyoteTimer.is_stopped():
		velocity.y = clamp(velocity.y - jump, -velocity_max.y, velocity_max.y)
		$CoyoteTimer.stop()
	
	#apply gravity
	velocity.y = clamp(velocity.y +gravity, -velocity_max.y, velocity_max.y)


func update_feet(delta):
	var foot_offset = Vector2(0, -4)
	var left_foot_target_pos = Vector2.ZERO
	var right_foot_target_pos = Vector2.ZERO
	
	#set feet target positions
	if $CoyoteTimer.is_stopped():
		left_foot_target_pos = lerp(left_jump_pos.global_position, left_walk_pivot.global_position, abs(velocity.y) / velocity_max.y)
		right_foot_target_pos = lerp(right_jump_pos.global_position, right_walk_pivot.global_position,  abs(velocity.y) / velocity_max.y)
	else:
		left_foot_target_pos.x = left_walk_pos.global_position.x + foot_offset.x
		left_foot_target_pos.y = clamp(left_walk_pos.global_position.y + foot_offset.y, left_walk_pivot.global_position.y - 32, left_walk_pivot.global_position.y)
		right_foot_target_pos.x = right_walk_pos.global_position.x + foot_offset.x
		right_foot_target_pos.y = clamp(right_walk_pos.global_position.y + foot_offset.y, right_walk_pivot.global_position.y - 32, right_walk_pivot.global_position.y)
	
	#lerp feet to target positions
	left_foot.global_position = lerp(left_foot.global_position, left_foot_target_pos, clamp(left_foot.global_position.distance_to(left_foot_target_pos) / max_feet_lerp_val * delta * 1000, 0, 1))
	right_foot.global_position = lerp(right_foot.global_position, right_foot_target_pos, clamp(right_foot.global_position.distance_to(right_foot_target_pos) / max_feet_lerp_val * delta * 1000, 0, 1))
	
	if velocity.x != 0 and not $CoyoteTimer.is_stopped():
		left_walk_pivot.rotation_degrees += velocity.x * delta * 1000 * foot_speed_mult
		right_walk_pivot.rotation_degrees += velocity.x * delta * 1000 * foot_speed_mult
	else:
		left_walk_pivot.rotation_degrees = 0
		right_walk_pivot.rotation_degrees = 0


func update_lean(delta):
	var target_rotation_degrees = -velocity.x
	$BatteryPivot.rotation_degrees = lerp($BatteryPivot.rotation_degrees, target_rotation_degrees, clamp(abs($BatteryPivot.rotation_degrees - target_rotation_degrees) / max_lean_lerp_val * delta * 1000, 0, 1))


func socket_align(delta):
	if abs(global_position.x - socket_align_x) > 0.1:
		global_position.x = lerp(global_position.x, socket_align_x, 0.2)
	else:
		socket_align_x = -1


# set/get functions --------------------------------------


# signal functions --------------------------------------


