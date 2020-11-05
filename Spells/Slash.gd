extends Spell

func _ready ():
	position = enemy.position
	$AnimatedSprite.play ('start')

func set_attributes () -> void:
	damage = 20
	logo = load ('res://Assets/Images/Spells/slash_button.png')

func _on_AnimatedSprite_animation_finished():
	enemy.take_damage (damage)
	destroy ()
