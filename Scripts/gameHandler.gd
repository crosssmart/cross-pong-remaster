extends Node
var p1Points : int
var p2Points : int
@onready var scriptBall = get_node("ball")
var touchCount : int = 0

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#RESET
	if Input.is_physical_key_pressed(Key.KEY_R):
		scriptBall.ball_reset()

	#Velocity Change
	if touchCount == 3 :
		touchCount = 0
		scriptBall.ball_speed += 50
	pass


	
