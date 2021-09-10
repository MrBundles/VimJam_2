extends Control

# references ------------------------------------------------------------------


# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------
export(GVM.MENU_SCENE_POSITIONS) var default_position_id = GVM.MENU_SCENE_POSITIONS.center setget set_default_position_id
export(GVM.MENU_SCENE_POSITIONS) var empty_menu_scene_position_id = GVM.MENU_SCENE_POSITIONS.default
export(GVM.MENU_SCENE_POSITIONS) var main_menu_scene_position_id = GVM.MENU_SCENE_POSITIONS.default
export(GVM.MENU_SCENE_POSITIONS) var levels_menu_scene_position_id = GVM.MENU_SCENE_POSITIONS.default
export(GVM.MENU_SCENE_POSITIONS) var settings_menu_scene_position_id = GVM.MENU_SCENE_POSITIONS.default
export(GVM.MENU_SCENE_POSITIONS) var bugs_menu_scene_position_id = GVM.MENU_SCENE_POSITIONS.default
export(GVM.MENU_SCENE_POSITIONS) var pause_menu_scene_position_id = GVM.MENU_SCENE_POSITIONS.default
export(GVM.MENU_SCENE_POSITIONS) var credits_menu_scene_position_id = GVM.MENU_SCENE_POSITIONS.default
export(GVM.MENU_SCENE_POSITIONS) var screenshots_menu_scene_position_id = GVM.MENU_SCENE_POSITIONS.default
export(GVM.MENU_SCENE_POSITIONS) var editor_menu_scene_position_id = GVM.MENU_SCENE_POSITIONS.default

var screen_size
var menu_scene_position_array

# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	GSM.connect("change_scene", self, "_on_change_scene")
	
	# initialize variables
	screen_size = get_viewport_rect().size
	
	menu_scene_position_array = [
		Vector2(0, 0),										# default
		Vector2(screen_size.x / 2, -2 * screen_size.y),		# up
		Vector2(screen_size.x / 2, 2 * screen_size.y),		# down
		Vector2(-2 * screen_size.x, screen_size.y / 2),		# left
		Vector2(2 * screen_size.x, screen_size.y / 2),		# right
		Vector2(screen_size.x / 2, screen_size.y / 2),		# center
		Vector2(screen_size.x / 2, screen_size.y*0.3),		# center up
		Vector2(screen_size.x / 2, screen_size.y*0.7),		# center down
		Vector2(screen_size.x*0.3, screen_size.y / 2),		# center left
		Vector2(screen_size.x*0.7, screen_size.y / 2)		# center right
	]
	
	self.default_position_id = default_position_id
	
	# initialize rect position
	rect_position = menu_scene_position_array[default_position_id] - rect_size / 2
	
	# make menus visible
	show()


func _process(delta):
	pass


# helper functions ------------------------------------------------------------



# set/get functions -----------------------------------------------------------
func set_default_position_id(new_val):
	default_position_id = new_val
	
	if menu_scene_position_array:
		menu_scene_position_array[0] = menu_scene_position_array[default_position_id]


# signal functions ------------------------------------------------------------
func _on_change_scene(new_game_scene_id, new_menu_scene_id, transition_type, transition_direction):
	var target_rect_position
	
	match new_menu_scene_id:
		GVM.MENU_SCENE_IDS.empty:
			target_rect_position = menu_scene_position_array[empty_menu_scene_position_id]
		GVM.MENU_SCENE_IDS.main:
			target_rect_position = menu_scene_position_array[main_menu_scene_position_id]
		GVM.MENU_SCENE_IDS.levels:
			target_rect_position = menu_scene_position_array[levels_menu_scene_position_id]
		GVM.MENU_SCENE_IDS.settings:
			target_rect_position = menu_scene_position_array[settings_menu_scene_position_id]
		GVM.MENU_SCENE_IDS.bugs:
			target_rect_position = menu_scene_position_array[bugs_menu_scene_position_id]
		GVM.MENU_SCENE_IDS.pause:
			target_rect_position = menu_scene_position_array[pause_menu_scene_position_id]
		GVM.MENU_SCENE_IDS.credits:
			target_rect_position = menu_scene_position_array[credits_menu_scene_position_id]
		GVM.MENU_SCENE_IDS.screenshots:
			target_rect_position = menu_scene_position_array[screenshots_menu_scene_position_id]
		GVM.MENU_SCENE_IDS.editor:
			target_rect_position = menu_scene_position_array[editor_menu_scene_position_id]
	
	# adjust target rect position to account for menu dimensions and keep the menu centered on target
	target_rect_position -= rect_size / 2
	
	$MenuTween.stop_all()
	$MenuTween.interpolate_property(self, "rect_position", rect_position, target_rect_position, .5, Tween.TRANS_QUART, Tween.EASE_OUT, 0.0)
	$MenuTween.start()
	
	

