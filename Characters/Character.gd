extends Area2D

class_name Character

var DamageVisual = load ('res://UI/DamageVisual/DamageVisual.tscn')

var Slash = load ('res://Spells/Slash.tscn')
var Fireball = load ('res://Spells/Fireball.tscn')
var Darkball = load ('res://Spells/Darkball.tscn')

var life : int 
var mana : int = 3
var spells_list = [Slash, Fireball, Darkball]

onready var aura : Sprite = $Aura
var current_enemy : Character
onready var current_spell : PackedScene
var team : int

signal is_pressed (character)

func _init (_name : String, _life : int):
	name = _name
	life = _life

func start_turn () -> void:
	current_enemy = null
	current_spell = null
	aura.modulate = Color ('66eaf8')
	
func select_enemy (enemy : Character) -> void:
	current_enemy = enemy
	
func take_damage (damage : int) -> void:
	var damage_visual = DamageVisual.instance ()
	damage_visual.text = str (-damage)
	add_child (damage_visual)
	
	life -= damage
	if life <= 0:
		die ()
		
func die () -> void:
	queue_free ()
	
func end_turn () -> void:
	aura.modulate = Color ('0066eaf8')
	
func set_on_enemy () -> void:
	aura.modulate = Color ('f86666')
	
func set_off_enemy () -> void:
	aura.modulate = Color ('0066eaf8')

func _on_Character_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed ():
		emit_signal ('is_pressed', self)
