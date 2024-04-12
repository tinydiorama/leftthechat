extends MarginContainer


func _on_close_button_pressed():
	self.hide()


func _on_new_game_pressed():
	DirAccess.remove_absolute("user://savegame.tres")
	get_tree().reload_current_scene()
