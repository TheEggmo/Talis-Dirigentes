extends Control

var start_time
var end_time

func _ready():
	$ColorRect.visible = true
	EventBus.connect("game_end", self, "show_hud")
	hide()
	$Text.hide()
	start_time = OS.get_ticks_msec()

func show_hud():
	visible = true
	$Timer.start(3)
	end_time = OS.get_ticks_msec()


func _on_Timer_timeout():
	$Text.show()
	var run_time = (end_time-start_time) / 1000.0 #in seconds
	
	var seconds = fmod(run_time, 60)
	var minutes = (run_time - seconds) / 60
	
	$Text/Label.text = "You survived for:\n %s minutes, %s seconds!" % [str(minutes), str(round(seconds))]


func _on_Button_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false
