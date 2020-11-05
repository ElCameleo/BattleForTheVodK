extends Node2D

class_name Game

onready var teams : Node2D = $Positions
onready var characters_controller : YSort = $CharactersController
onready var Thief = load ('res://Characters/Thief.tscn')
onready var attack_handler = $AttackHandler
onready var ui = $UI

func _ready () -> void:
	characters_controller.connect ('update_ui', self, 'update_ui')	
	ui.attack_button_controller.connect ('spell_chosen', characters_controller, 'on_spell_chosen')
	instanciate_characters ()
	start_round ()
	
func instanciate_characters () -> void:
	for i in range (2):
		for game_position in teams.get_child (i).get_children ():
			var thief = Thief.instance ()
			thief.position = game_position.position
			thief.team = i
			thief.connect ('is_pressed', characters_controller, 'on_character_pressed')
			characters_controller.add_child (thief)
		
func start_round () -> void:
	characters_controller.start_round ()

func end_round():
	attack_handler.start (characters_controller.get_children ())

func attacks_ended():
	start_round ()

func update_ui ():
	ui.update_content (characters_controller.get_current_character ())	
	
