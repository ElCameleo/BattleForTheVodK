extends CanvasLayer

onready var life_label = $Life/Label
onready var mana_label = $Mana/Label
onready var attack_button_controller = $AttackButtonController

func update_content (character : Character) -> void:
	life_label.text = str (character.life)
	mana_label.text = str (character.mana)
	attack_button_controller.update_content (character)
