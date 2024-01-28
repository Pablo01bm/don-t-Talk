extends Node2D

signal object_deleted

var rect_size = 10

func _ready():
	pass  # Any initialization code for your object

func delete_object():
	queue_free()
	emit_signal("object_deleted")
