extends Control

func _input(event):
	# Detecta si presionas Enter o Espacio para ir al Menú Principal
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://scenas/Menu.tscn")
		
	# Si prefieres que con "ESC" o "P" cierre el juego por completo:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
