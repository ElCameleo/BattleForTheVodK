extends TextureButton

var current_spell
signal is_pressed (button)

func _on_AttackButton_pressed():
	emit_signal ('is_pressed', self)

func update_content (spell_scene):
	$Selected.visible = false
	var spell = spell_scene.instance ()
	spell.set_attributes ()
	texture_normal = spell.logo
	current_spell = spell_scene

func select ():
	$Selected.visible = true
	
func deselect ():
	$Selected.visible = false
