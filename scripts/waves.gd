extends Sprite2D

@export_range(0, 100) var frequency: float = 0.5
@export_range(0, 100) var amplitude: float = 10
var time = 0
 
func _physics_process(delta):
	time += delta
	var movement = cos(time * frequency) * amplitude
	position.y += movement * delta
