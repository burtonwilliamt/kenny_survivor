class_name Meat extends RigidBody2D

const MAX_SPEED = 50

func _physics_process(_delta):
	linear_velocity = linear_velocity.limit_length(MAX_SPEED)