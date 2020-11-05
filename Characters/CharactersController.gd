extends YSort

signal end_round
signal update_ui

var current_index : int = 0

func get_current_character () -> Character:
	return get_children () [current_index]
	
func go_to_next_character () -> bool:
	current_index = (current_index + 1) % get_child_count ()
	return current_index != 0

func start_round () -> void:
	current_index = 0
	start_turn ()

func start_turn () -> void:
	get_current_character ().start_turn ()
	emit_signal ('update_ui')
	for enemy in get_current_enemys (): enemy.set_on_enemy ()
	
func end_turn () -> void:
	get_current_character ().end_turn ()
	for enemy in get_current_enemys (): enemy.set_off_enemy ()	
	if go_to_next_character ():
		start_turn ()
	else:
		emit_signal ('end_round')
	
	
func get_current_enemys () -> Array:
	var list : Array = []
	for character in get_children ():
		if character.team != get_current_character ().team:
			list.append (character) 
	return list

func on_character_pressed (character : Character) -> void:
	if character in get_current_enemys () and get_current_character ().current_spell != null:
		get_current_character ().current_enemy = character
		end_turn ()

func on_spell_chosen (spell : PackedScene) -> void:
	get_current_character ().current_spell = spell
