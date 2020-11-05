extends Node

var current_index : int = 0
var current_spell : Spell
var Slash = load ('res://Spells/Slash.tscn')
var Fireball = load ('res://Spells/Fireball.tscn')
var Darkball = load ('res://Spells/Darkball.tscn')
var characters : Array = []

signal attacks_ended

func get_current_character ():
	return characters [current_index]

func start (_characters : Array) -> void:
	characters = _characters
	current_index = 0
	instanciate_spell()
	
func instanciate_spell () -> void:
	if get_current_character () == null or get_current_character ().current_enemy == null:
		spell_ended ()
		return
	current_spell = get_current_character().current_spell.instance ()
	current_spell.set_attributes ()
	current_spell.add_characters (get_current_character (), get_current_character ().current_enemy)
	current_spell.connect ('spell_ended', self, 'spell_ended')
	add_child (current_spell)

func spell_ended () -> void:
	current_index += 1
	yield(get_tree().create_timer(.1), "timeout")
	if current_index < characters.size ():
		instanciate_spell()
	else: emit_signal ('attacks_ended')
	
