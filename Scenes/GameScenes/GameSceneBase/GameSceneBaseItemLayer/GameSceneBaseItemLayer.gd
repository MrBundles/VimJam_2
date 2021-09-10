extends Node2D

# references ------------------------------------------------------------------


# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------
export(GVM.EDITOR_CATEGORY_IDS) var editor_category_id = GVM.EDITOR_CATEGORY_IDS.null


# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	GSM.connect("set_category_visibility", self, "_on_set_category_visibility")
	GSM.connect("editor_instance_item", self, "_on_editor_instance_item")
	
	# initialize setgets
	pass


func _process(delta):
	pass


func _get_configuration_warning():
	if 0:
		return "Configuration Warning String"
	else:
		return ""


# helper functions ------------------------------------------------------------



# set/get functions -----------------------------------------------------------



# signal functions ------------------------------------------------------------
func _on_set_category_visibility(new_editor_category_id, new_visibility):
	if new_editor_category_id == editor_category_id:
		visible = new_visibility


func _on_editor_instance_item(editor_item):
	var editor_item_instance = editor_item.instance()
	
	var editor_item_info = editor_item_instance.get_node_or_null("FeatureEditorInfo")
	
	if editor_item_info.editor_category_id == editor_category_id:
		add_child(editor_item_instance)
	else:
		editor_item_instance.queue_free()

