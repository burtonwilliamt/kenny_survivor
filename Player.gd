extends CharacterBody2D


@export var speed: float = 10000.0

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction.normalized()*speed*delta

	move_and_slide()
