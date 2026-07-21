extends CanvasLayer

var coins = 0
var heart1
var heart2
var heart3

func _ready():
	heart1 = get_node("Heart1")
	heart2 = get_node("Heart2")
	heart3 = get_node("Heart3")
	$CoinCollectedText.text = str(coins)

func handleHearts(lifes):
	if lifes == 0:
		heart1.visible = false
	if lifes == 1:
		heart2.visible = false
	if lifes == 2:
		heart3.visible = false

func handleCoinCollected():
	print("Coin Collected")
	coins += 1
	$CoinCollectedText.text = str(coins)
	if coins == 3:
		# Si estamos en el Mundo 3, vamos a la pantalla de victoria
		if get_tree().current_scene.name == "Mundo3":
			get_tree().change_scene_to_file("res://scenas/Victoria.tscn")
		else:
			get_tree().change_scene_to_file("res://scenas/Mundo" + str(int(get_tree().current_scene.name) + 1) + ".tscn")
