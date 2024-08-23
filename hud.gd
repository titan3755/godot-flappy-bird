extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_score(score):
	$ScoreLabel.text = str(score)

func hide_show(hide_no, value):
	if hide_no == 0:
		if value == true:
			$ScoreLabel.hide()
		else:
			$ScoreLabel.show()
	elif hide_no == 1:
		if value == true:
			$GameStartLabel.hide()
		else:
			$GameStartLabel.show()
	
