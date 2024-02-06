extends Node2D

@onready var pause_menu = $Camera2D/PauseMenu
@onready var color_rec = $Camera2D/ColorRect
var paused = false

var spawn_interval = 0.5
var row_spacing = 100
var objects_per_row = 5

var current_row = 0
var current_column = 0

var object_array = []  # To keep track of spawned objects
var removal_timer = Timer.new()


func _ready():
	# Set up the removal timer
	removal_timer.wait_time = (float(Global.minutes_to_set) * 60) + float(Global.seconds_to_set) # Set the time in seconds
	removal_timer.one_shot = false
	removal_timer.connect("timeout", Callable(self, "_on_removal_timer_timeout"))
	add_child(removal_timer)
	removal_timer.start()

func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		pause_menu_action()
	if Input.is_action_just_pressed("add_item"):
		print("Pulsé")
		spawn_object()
	if Input.is_action_just_pressed("delete_item"):
		_on_removal_timer_timeout()

func pause_menu_action():
	if paused:
		color_rec.hide()
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		color_rec.show()
		pause_menu.show()
		Engine.time_scale = 0
	
	paused = !paused

func spawn_object():
	var object_scene = preload("res://scenes/talkIndicator/talkIndicator.tscn")
	var new_object = object_scene.instantiate()
	get_node("faults").add_child(new_object)

	var screen_size = get_viewport_rect().size
	var object_size = Vector2(150, 100)

	new_object.position.x = current_column * (object_size.x + 10)  # Adjust 10 for spacing
	new_object.position.y = current_row * (object_size.y + row_spacing)

	current_column += 1
	if current_column >= objects_per_row:
		current_column = 0
		current_row += 1
	
	if current_row * (object_size.y + row_spacing) > screen_size.y:
		current_row = 0
	
	object_array.append(new_object)

func _on_object_deleted():
	if object_array.size() > 0:
		object_array[0].queue_free()
		object_array.remove_at(0)  # Remove the first object from the array
		# Update positions of remaining objects
		if current_column - 1 < 0 && current_row > 0: 
			current_column = 4
			current_row -= 1
		else: 
			current_column = current_column - 1
			if current_column <= 0:
				current_column = 0
		print ("Current column after: " + str(current_column))
		print ("Current row after: " + str(current_row))
		for i in range(object_array.size()):
			var object_size = Vector2(150, 100)
			object_array[i].position.x = i % objects_per_row * (object_size.x + 10)  # Adjust 10 for spacing
			object_array[i].position.y = i / objects_per_row * (object_size.y + row_spacing)
			

func _on_removal_timer_timeout():
	print("ARRAY " + str(object_array.size()))
	if object_array.size() > 0:
		# Timer expired, remove the first object
		_on_object_deleted()
