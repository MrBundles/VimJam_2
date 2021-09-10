extends Node

# references ------------------------------------------------------------------


# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------
export(Array, PackedScene) var game_scenes
var current_game_scene_id setget set_current_game_scene_id
var current_menu_scene_id setget set_current_menu_scene_id

# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	GSM.connect("quit", self, "_on_quit")
	GSM.connect("change_scene", self, "_on_change_scene")
	GSM.connect("reset_scene", self, "_on_reset_scene")
	
	
	# initialize setgets
	self.current_game_scene_id = current_game_scene_id
	self.current_menu_scene_id = current_menu_scene_id


func _process(delta):
	pass


# helper functions ------------------------------------------------------------
func is_valid_game_scene_id(new_game_scene_id):
	return new_game_scene_id > -1 and new_game_scene_id < game_scenes.size()


func clear_game_scene():
	for child in $GameSceneLayer.get_children():
		child.queue_free()


func add_game_scene(new_game_scene_id):
	# this short delay is to avoid any overlap with the current game scene during a reset
	yield(get_tree().create_timer(.01), "timeout")
	
	var new_game_scene_instance = game_scenes[new_game_scene_id].instance()
	$GameSceneLayer.add_child(new_game_scene_instance)


# set/get functions -----------------------------------------------------------
func set_current_game_scene_id(new_val):
	current_game_scene_id = new_val
	
	GVM.current_game_scene_id = current_game_scene_id


func set_current_menu_scene_id(new_val):
	current_menu_scene_id = new_val
	
	GVM.current_menu_scene_id = current_menu_scene_id
	
	# set pause mode
	get_tree().paused = current_menu_scene_id != GVM.MENU_SCENE_IDS.empty and current_menu_scene_id != GVM.MENU_SCENE_IDS.editor


# signal functions ------------------------------------------------------------
func _on_quit():
	get_tree().quit()


func _on_change_scene(new_game_scene_id, new_menu_scene_id, transition_type, transition_direction):
	# when changing scenes, I will often pass -1 as the new_game_scene_id to keep the current game scene
	if is_valid_game_scene_id(new_game_scene_id):
		self.current_game_scene_id = new_game_scene_id
	
	self.current_menu_scene_id = new_menu_scene_id
	
	match transition_type:
		GVM.TRANSITIONS.cut:
			if is_valid_game_scene_id(new_game_scene_id):
				clear_game_scene()
				add_game_scene(new_game_scene_id)
		
		GVM.TRANSITIONS.fade:
			pass
		
		GVM.TRANSITIONS.dissolve:
			pass
		
		GVM.TRANSITIONS.wipe:
			pass
		
		GVM.TRANSITIONS.slide:
			pass


func _on_reset_scene():
	clear_game_scene()
	add_game_scene(current_game_scene_id)
