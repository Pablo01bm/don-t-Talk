extends LineEdit

var lastEnteredValue: String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	grab_focus()
	connect("text_changed", Callable(self, "_on_text_changed"))

func _on_text_changed(new_text: String):
	# Update the lastEnteredValue variable whenever the text changes
	lastEnteredValue = new_text
	
	Global.seconds_to_set = lastEnteredValue
	# You can print or use the value in any way you want
	print("Last entered value: ", lastEnteredValue)

