extends Control

func _ready():
	# Forzamos a que el menú empiece oculto al cargar el nivel
	visible = false

func _input(event):
	if event.is_action_pressed("pause"):
		print("Pausado")
		# Primero cambiamos el estado de pausa del juego
		get_tree().paused = not get_tree().paused
		# Luego igualamos la visibilidad al estado actual de la pausa
		visible = get_tree().paused
