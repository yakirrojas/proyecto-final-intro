extends CharacterBody2D

var gravity = 10
var speed = 25
var moving_left = true

func _ready():
	$AnimationPlayer.play("Walk")

func _process(_delta):
	move_character()
	turn()

func move_character():
	velocity.y += gravity
	if moving_left:
		velocity.x = -speed
	else:
		velocity.x = speed
	
	move_and_slide()

func turn():
	if not $Area2D/RayCast2D.is_colliding():
		moving_left = !moving_left
		
		# Movemos el RayCast usando la ruta completa
		$Area2D/RayCast2D.position.x *= -1
		
		# Volteamos el dibujo del enemigo
		$Sprite2D.flip_h = not moving_left

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "Player":
		body._loseLife(position.x)
	pass
