extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		# Accedemos al nodo FallSound que está dentro del Player (body)
		var fall_sound = body.get_node_or_null("FallSound")
		if fall_sound:
			fall_sound.play()
			await fall_sound.finished
		
		print("Hemos caido")
		get_tree().reload_current_scene()
