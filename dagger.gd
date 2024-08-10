extends CharacterBody2D

@export var direction: Vector2

const speed = 100

func _physics_process(delta):
	velocity = direction*speed*delta
	self.position += velocity

