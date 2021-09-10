extends Node
# GLOBAL VARIABLE MANAGER

# references ------------------------------------------------------------------


# signals ---------------------------------------------------------------------


# enums -----------------------------------------------------------------------
enum THEMES {default, light, dark}
enum DIRECTION {up, down, left, right}
enum ALIGN {left, center, right, fill}
enum VALIGN {top, center, bottom, fill}
enum GAME_MODES {normal, developer, speedrun, hardcore, endless, sandbox}
enum MENU_SCENE_IDS {empty, main, levels, settings, bugs, pause, credits, screenshots, editor}
enum MENU_SCENE_POSITIONS {default, up, down, left, right, center, center_up, center_down, center_left, center_right}
enum TRANSITIONS {cut, fade, dissolve, wipe, slide}

# tween enums
enum EASE_TYPES {ease_in, ease_out, ease_in_out, ease_out_in}
enum TRANSITION_TYPES {trans_linear, trans_sine, trans_quint, trans_quart, trans_quad, trans_expo, trans_elastic, trans_cubic, trans_circ, trans_bounce, trans_back}

# audio enums
enum AUDIO_BUS_IDS {master, music, effects}

# popup enums
enum POPUP_IDS {file_browser, confirmation}

# level editor enums
enum EDITOR_CATEGORY_IDS {characters, environment, objects, text, triggers, null}
enum EDITOR_POINTER_PROFILES {single, circle, square}
enum EDITOR_POINTER_MODES {select, move, rotate}
enum EDITOR_MODES {null, edit, test, debug}
#enum EDITOR_VIEW_MODES {null, }

# variables -------------------------------------------------------------------
# build version
export var version = 0.0

# current theme
export(Array, Theme) var theme_array
export(THEMES) var current_theme_id setget set_current_theme_id

# game mode
var game_mode = GAME_MODES.normal

# current scenes
var current_game_scene_id = 0
var current_menu_scene_id = MENU_SCENE_IDS.empty

# recent director, this is used when saving files
var recent_directory = ""



# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	
	
	# initialize variables
	self.current_theme_id = current_theme_id


func _process(delta):
	pass


# helper functions ------------------------------------------------------------


# set/get functions -----------------------------------------------------------
func set_current_theme_id(new_val):
	current_theme_id = new_val
	GSM.emit_signal("change_theme", current_theme_id)


# signal functions ------------------------------------------------------------
