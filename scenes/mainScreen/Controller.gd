extends Node2D

var spawn_interval = 0.5
var row_spacing = 100
var objects_per_row = 5

var current_row = 0
var current_column = 0

#func _ready():
	#connect("object_deleted", self, "_on_object_deleted")

func _process(delta):
	if Input.is_action_just_pressed("add_item"):
		spawn_object()

func spawn_object():
	var object_scene = preload("res://scenes/talkIndicator/talkIndicator.tscn")
	var new_object = object_scene.instantiate()
	add_child(new_object)

	var screen_size = get_viewport_rect().size
	var object_size = new_object.rect_size

	new_object.position.x = current_column * (object_size.x + 10)  # Adjust 10 for spacing
	new_object.position.y = current_row * (object_size.y + row_spacing)

	current_column += 1
	if current_column >= objects_per_row:
		current_column = 0
		current_row += 1

	if current_row * (object_size.y + row_spacing) > screen_size.y:
		current_row = 0

func _on_object_deleted():
	# Handle the deletion of an object
	# You may want to implement logic here to find and update the spawn position accordingly
	pass
