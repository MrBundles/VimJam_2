tool
extends FeatureButtonAction

# references ------------------------------------------------------------------


# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------
export var new_game_scene_id = -1
export(GVM.MENU_SCENE_IDS) var new_menu_scene_id = GVM.MENU_SCENE_IDS.empty
export(GVM.TRANSITIONS) var transition = GVM.TRANSITIONS.cut
export(GVM.DIRECTION) var direction = GVM.DIRECTION.left


# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	
	
	pass


func _process(delta):
	pass


# helper functions ------------------------------------------------------------



# set/get functions -----------------------------------------------------------



# signal functions ------------------------------------------------------------
func _on_button_pressed():
	GSM.emit_signal("change_scene", new_game_scene_id, new_menu_scene_id, transition, direction)
