extends Node
# GLOBAL SIGNAL MANAGER

# references ------------------------------------------------------------------


# signals ---------------------------------------------------------------------

# audio signals
signal set_bus_volume					# audio_bus_id, new_val
signal set_bus_mute						# audio_bus_id, new_val

# scene management signals
signal change_scene						# new_game_scene_id, new_menu_scene_id, transition_type, transition_direction
signal reset_scene
signal resume_scene
signal quit


signal change_theme						# new_theme_id
signal send_bug_report
signal bug_report_sent
signal take_screenshot
signal screenshot_taken					# screenshot_texture
signal delete_screenshot				# screenshot_name
signal rename_screenshot				# screenshot_name, new_screenshot_name

signal screenshot_button_pressed		# button_name

# level editor signals
signal editor_select_category			# new_editor_category_id
signal editor_instance_item				# editor_item
signal set_category_visibility			# new_editor_category_id, new_visibility
signal set_editor_pointer_mode			# new_editor_pointer_mode
signal set_editor_pointer_profile		# new_editor_pointer_profile
signal set_editor_pointer_size			# new_editor_pointer_size
signal set_editor_pointer_visible		# new_editor_pointer_visible
signal set_editor_grid_snap				# new_editor_grid_snap
signal set_editor_grid_size				# new_editor_grid_size
signal set_editor_mode					# new_editor_mode
signal add_item							# editor_item, editor_item_global_position
signal set_editor_panning				# new_editor_panning
signal set_editor_zoom					# new_editor_zoom
signal editor_box_select


# variables -------------------------------------------------------------------



# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	
	
	pass


func _process(delta):
	pass


# helper functions ------------------------------------------------------------



# set/get functions -----------------------------------------------------------



# signal functions ------------------------------------------------------------


