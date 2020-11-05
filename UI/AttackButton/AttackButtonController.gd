extends Control

var spell_selected
signal spell_chosen (spell)

func _ready ():
	for button in get_children ():
		button.connect ('is_pressed', self, 'on_button_pressed')

func update_content (character : Character):
	for i in range (get_child_count ()):
		get_child (i).update_content (character.spells_list [i])

func on_button_pressed (button):
	for b in get_children (): b.deselect ()
	button.select ()	
	spell_selected = button.current_spell
	emit_signal ('spell_chosen', spell_selected)

