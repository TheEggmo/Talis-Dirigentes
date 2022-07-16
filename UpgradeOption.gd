extends VBoxContainer

var option

func setup(title, text, op):
	$Label.text = title
	$Label2.text = text
	option = op

func _on_Button_button_down():
	LevelUp.levelup_end(option)
	
