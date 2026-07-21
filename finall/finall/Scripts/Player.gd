extends CharacterBody2D

const maxSpeed = 50
const moveSpeed = 20 # Agregado porque faltaba declararlo en la imagen
const jumpHeight = -300
# const up = Vector2(0,-1) # En Godot 4 esto ya no se usa, el motor lo sabe automáticamente
const gravity = 15
var lifes = 3

@onready var sprite = $Sprite2D
@onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):

	velocity.y += gravity
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		sprite.flip_h = true
		animationPlayer.play("Walk")
		velocity.x = min(velocity.x + moveSpeed, maxSpeed)
		
	elif Input.is_action_pressed("ui_left"):
		sprite.flip_h = false
		animationPlayer.play("Walk")
		velocity.x = max(velocity.x - moveSpeed, -maxSpeed)
		
	else:
		animationPlayer.play("Idle")
		friction = true
		
	if is_on_floor():
		if Input.is_action_pressed("ui_accept"):
			velocity.y = jumpHeight
		if friction == true:
			velocity.x = lerp(velocity.x, 0.0, 0.5)
	else:
		if friction == true:
			velocity.x = lerp(velocity.x, 0.0, 0.01)
			
	move_and_slide()

func add_Coin():
	var canvasLayer = get_tree().get_root().find_child("CanvasLayer", true, false)
	canvasLayer.handleCoinCollected()

func _on_spikes_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if velocity.x < 0:
			_loseLife(position.x - 100) 
		else:
			_loseLife(position.x + 100) 

func _loseLife(enemyposx):
	# Reproducir el sonido de daño
	$HurtSound.play()
	if position.x < enemyposx:
		velocity.x = -200
		velocity.y = -100
		
	if position.x > enemyposx:
		velocity.x = 200
		velocity.y = -100
		
	lifes = lifes - 1
	print("Perdemos vida, vida actual: " + str(lifes))
	
	var canvasLayer = get_tree().get_root().find_child("CanvasLayer", true, false)
	if canvasLayer:
		canvasLayer.handleHearts(lifes)
		
	if lifes <= 0:
		get_tree().reload_current_scene()
