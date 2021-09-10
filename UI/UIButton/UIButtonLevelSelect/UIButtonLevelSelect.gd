tool
extends Button

# references ------------------------------------------------------------------


# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------
export var new_game_scene_id = -1 setget set_new_game_scene_id


# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	
	
	# initialize variables
	self.new_game_scene_id = new_game_scene_id


func _process(delta):
	pass


# helper functions ------------------------------------------------------------



# set/get functions -----------------------------------------------------------
func set_new_game_scene_id(new_val):
	new_game_scene_id = new_val
	
	text = str(new_game_scene_id).pad_zeros(2)
	
	if has_node("FeatureButtonActionGoTo"):
		$FeatureButtonActionGoTo.new_game_scene_id = new_game_scene_id


# signal functions ------------------------------------------------------------

