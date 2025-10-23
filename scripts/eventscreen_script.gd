extends Control

@onready var event_label: Label = $VBoxContainer/PanelContainer/Label
@onready var button_option1: Button = $VBoxContainer/HBoxContainer/Button1
@onready var button_option2: Button = $VBoxContainer/HBoxContainer/Button2

const DATA_FILE_PATH = "res://data/events.json"
var all_events_data = {}

func _ready():
	all_events_data = load_json_data(DATA_FILE_PATH)
	
	button_option1.pressed.connect(_on_option_button_pressed.bind("dummy_action_1"))
	button_option2.pressed.connect(_on_option_button_pressed.bind("dummy_action_2"))

	if all_events_data.has("start_event"):
		load_event("start_event")
	else:
		event_label.text = "Erro: Evento inicial não encontrado"

func load_json_data(path: String) -> Dictionary:
	var file = FileAccess.open(path, FileAccess.READ)
	if not file:
		printerr("Erro ao abrir o arquivo JSON: ", path)
		return {}
		
	var content = file.get_as_text()
	file.close()
	
	var json_result = JSON.parse_string(content)
	if not json_result is Dictionary:
		printerr("Erro ao analisar o JSON.")
		return {}
		
	return json_result


func load_event(event_id: String):
	if not all_events_data.has(event_id):
		printerr("Evento com ID '%s' não encontrado nos dados." % event_id)
		return

	var data = all_events_data[event_id]
	
	event_label.text = data.text
	button_option1.text = data.options[0].text
	button_option2.text = data.options[1].text
	
	button_option1.pressed.disconnect(_on_option_button_pressed)
	button_option1.pressed.connect(_on_option_button_pressed.bind(data.options[0].action))
	
	button_option2.pressed.disconnect(_on_option_button_pressed)
	button_option2.pressed.connect(_on_option_button_pressed.bind(data.options[1].action))


func _on_option_button_pressed(action_key: String):
	print("Ação executada: ", action_key)
	
	if action_key == "path_taken":
		load_event("forest_event")
