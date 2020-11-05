extends Spell

var target : Vector2
var speed = 0.5

func _ready ():
	position = character.position
	target = enemy.position
	$Tween.interpolate_property (self, "position", position, target, speed, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)
	$Tween.start ()
	look_at (target)
	
func set_attributes () -> void:
	damage = 30
	logo = load ('res://Assets/Images/Spells/fireball_button.png')

func _process (delta : float):
	if position.distance_to (target) < 5:
		$Sprite.visible = false
		$AnimatedSprite.play ('play')
		$Tween.stop(self, "position")
		rotation = 0
		set_process (false)


func _on_AnimatedSprite_animation_finished():
	enemy.take_damage (damage)
	destroy()
