extends VBoxContainer

# references ------------------------------------------------------------------
onready var username_input = get_node("HBoxContainer2/UsernameLineEdit")
onready var level_input = get_node("HBoxContainer2/LevelLineEdit")
onready var title_input = get_node("TitleLineEdit")
onready var steps_to_reproduce_input = get_node("TabContainer/Steps To Reproduce Problem/VBoxContainer")
onready var expected_result_input = get_node("TabContainer/ExpectedResult/TextEdit")
onready var actual_result_input = get_node("TabContainer/ActualResult/TextEdit")
onready var severity_input = get_node("HBoxContainer2/HBoxContainer/SeveritySelector")

onready var back_button = get_node("HBoxContainer/BackButton")
onready var resume_button = get_node("HBoxContainer/ResumeButton")

# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------
# initialize bug report data
var username				# optional itch username
var severity				# severity of the problem, 1: high/critical, 2: medium, 3: minor
var level					# level in which the bug appears
var title					# a brief description of the problem
var os_name					# name of host operating system
var model_name				# name of host model
var version					# build version
var date					# current date
var time					# current time
var steps_to_reproduce		# a few steps to reproduce the bug
var expected_result			# what you were expecting to happen
var actual_result			# what actually happened
var screenshot				# any related screenshots

# http request setup info
var form_url = "https://docs.google.com/forms/d/e/1FAIpQLSfswFZ3kJlb6lUj0w7Gk-5C8Qtat9dV_snIyl9GmYWSy-6CPA/formResponse"
var headers = ["Content-Type: application/x-www-form-urlencoded"]
var http = HTTPClient.new()



# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	GSM.connect("send_bug_report", self, "_on_send_bug_report")
	GSM.connect("change_scene", self, "_on_change_scene")
	
	pass


func _process(delta):
	pass


# helper functions ------------------------------------------------------------



# set/get functions -----------------------------------------------------------



# signal functions ------------------------------------------------------------
func _on_change_scene(new_game_scene_id, new_menu_scene_id, transition_type, transition_direction):
	if GVM.current_game_scene_id == 0:
		back_button.show()
		resume_button.hide()
	else:
		back_button.hide()
		resume_button.show()


func _on_send_bug_report():
	# pull report info
	username = username_input.value
	severity = severity_input.selected + 1
	level = level_input.value
	title = title_input.value
	os_name = OS.get_name()
	model_name = OS.get_model_name()
	version = GVM.version
	date = OS.get_date()
	time = OS.get_time()
	
	#iterate through steps and concatenate with step labels
	steps_to_reproduce = ""
	for i in range(steps_to_reproduce_input.get_child_count()):
		if steps_to_reproduce_input.get_child(i).value != "":
			steps_to_reproduce += "Step " + str(i+1) + ": " + steps_to_reproduce_input.get_child(i).value + "\n"
	
	expected_result = expected_result_input.text
	actual_result = actual_result_input.text
	screenshot				# any related screenshots
	
	var my_data = {
		"entry.1889711528" : username,
		"entry.2013703327" : severity,
		"entry.955132142" : level,
		"entry.637194498" : title,
		"entry.958543560" : os_name,
		"entry.857849159" : model_name,
		"entry.588370581" : str(version),
		"entry.606529848_year" : date.year,
		"entry.606529848_month" : date.month,
		"entry.606529848_day" : date.day,
		"entry.1983335027_hour" : str(time.hour).pad_zeros(2),
		"entry.1983335027_minute" : str(time.minute).pad_zeros(2),
		"entry.657287764" : steps_to_reproduce.http_escape().replace("%A", " ").http_unescape(),
		"entry.253048298" : expected_result.http_escape().replace("%A", " ").http_unescape(),
		"entry.363179869" : actual_result.http_escape().replace("%A", " ").http_unescape()
		}
	var headers_pool = PoolStringArray(headers)
	var my_data_ready = http.query_string_from_dict(my_data)
	var result = $HTTPRequest.request(form_url, headers_pool, false, http.METHOD_POST, my_data_ready)


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
#	print("Result: " + str(result) + "    Respons Code: " + str(response_code) + "    Headers: " + str(headers) + "    Body: " + str(body))
	GSM.emit_signal("bug_report_sent")
