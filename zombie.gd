extends CharacterBody2D


const SPEED = 3000.0

func _physics_process(delta):
	var player: CharacterBody2D = get_node("/root/Node2D/Player")
	# We assume the zombie and the player are siblings of the same node, so a 
	# direct position comparison is warranted.
	var direction = (player.position - self.position).normalized()
	velocity = direction * SPEED * delta

	move_and_slide()
