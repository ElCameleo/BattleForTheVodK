extends Area2D

class_name Spell

var damage
var logo

var character : Character
var enemy     : Character

signal spell_ended

func set_attributes () -> void : pass

func add_characters (_character, _enemy) -> void:
	character = _character
	enemy = _enemy

func destroy () -> void:
	queue_free ()
	emit_signal ('spell_ended')
