tool
extends HBoxContainer

# references ------------------------------------------------------------------


# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------
export(GVM.AUDIO_BUS_IDS) var audio_bus_id = GVM.AUDIO_BUS_IDS.music
export var audio_bus_label = "Music Volume" setget set_audio_bus_label


# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	GSM.connect("set_bus_volume", self, "_on_set_bus_volume")
	GSM.connect("set_bus_mute", self, "_on_set_bus_mute")
	
	# initialize variables
	$ButtonMute.pressed = AudioServer.is_bus_mute(audio_bus_id)
	self.audio_bus_label = audio_bus_label
	


func _process(delta):
	pass


# helper functions ------------------------------------------------------------



# set/get functions -----------------------------------------------------------
func set_audio_bus_label(new_val):
	audio_bus_label = new_val
	
	$Label.text = audio_bus_label


# signal functions ------------------------------------------------------------
func _on_set_bus_volume(new_audio_bus_id, new_val):
	if new_audio_bus_id == audio_bus_id and new_val != $HSlider.value:
		$HSlider.value = new_val


func _on_set_bus_mute(new_audio_bus_id, new_val):
	if new_audio_bus_id == audio_bus_id and new_val != $ButtonMute.pressed:
		$ButtonMute.pressed = new_val


func _on_ButtonMute_toggled(button_pressed):
	GSM.emit_signal("set_bus_mute", audio_bus_id, button_pressed)
	
	if button_pressed:
		$ButtonMute.text = "Unmute"
	else:
		$ButtonMute.text = "Mute"


func _on_HSlider_value_changed(value):
	GSM.emit_signal("set_bus_volume", audio_bus_id, value)
