extends Area2D
signal coinCollected

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		# 1. Desactivamos la colisión y ocultamos la moneda de inmediato
		$CollisionShape2D.set_deferred("disabled", true)
		$Sprite2D.visible = false
		
		# 2. Sumamos la moneda al contador
		body.add_Coin()
		
		# 3. Reproducimos el sonido
		$AudioStreamPlayer2D.play()
		
		# 4. Esperamos a que la señal 'finished' del audio termine de sonar
		await $AudioStreamPlayer2D.finished
		
		# 5. Borramos el nodo recién cuando el sonido terminó
		queue_free()
		pass # Replace with function body.
