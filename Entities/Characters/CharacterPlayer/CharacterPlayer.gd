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
export var float_val = 10.0
export var foot_speed_mult = 2.0

export var max_feet_lerp_val = 25.0
export var leg_color = Color(1,1,1,1)
export var leg_width = 10
export var max_lean_lerp_val = 1.0

var colliding_with_body = false
var socket_align_x = -1.0
var plugged_in = false

var hiding = false

# draw variables
export var body_position = Vector2.ZERO
export var body_radius = 64.0
export(Color) var body_color = Color(1,1,1,1)


# main functions --------------------------------------
func _ready():
	# connect signals
	GSM.connect("set_hiding", self, "_on_set_hiding")
	
	velocity_max_init = velocity_max


func _physics_process(delta):
	get_input()
	update()
	move_and_slide(velocity * delta * 1000, Vector2.UP, false, 4, PI/4, false)


func _draw():
	# draw body
	draw_circle(body_position, body_radius, body_color)


# helper functions --------------------------------------
func get_input():
	#horizontal inputs
	if Input.is_action_pressed("ui_left") and not hiding:
		velocity.x = clamp(velocity.x - h_accel, -velocity_max.x, velocity_max.x)
	elif Input.is_action_pressed("ui_right") and not hiding:
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
	if Input.is_action_pressed("ui_up") and not $CoyoteTimer.is_stopped() and not hiding:
		velocity.y = clamp(velocity.y - jump, -velocity_max.y, velocity_max.y)
		$CoyoteTimer.stop()
	
	#apply gravity
	velocity.y = clamp(velocity.y +gravity, -velocity_max.y, velocity_max.y)
	
	#apply float if falling and holding the jump button
	if Input.is_action_pressed("ui_up") and velocity.y > 0 and not hiding:
		velocity.y -= float_val


# set/get functions --------------------------------------


# signal functions --------------------------------------
func _on_set_hiding(new_hiding):
	hiding = new_hiding

