extends VBoxContainer

var option

signal selected_option(val)

func setup(title, text, op):
	$Label.text = title
	$Label2.text = text
	option = op

func _on_Button_button_down():
	LevelUp.levelup_end(option)
	emit_signal("selected_option", option)
