class_name Monster
extends CharacterBody2D

var meat = preload("res://enemies/components/meat.tscn")

@export var speed: float = 3000.0
@export var health: float = 10.0

func _init():
	# Exist in the enemy layer (2)
	collision_layer = 0b00000000_00000000_00000000_00000010
	# Collide with other enemies, and the player (1, 2)
	collision_mask  = 0b00000000_00000000_00000000_00000011

func receive_damage(damage: float):
	self.health -= damage
	if self.health <= 0.0:
		var m = meat.instantiate()
		m.position = self.position
		get_node("/root/Node2D/Meat").call_deferred("add_child", m)
		self.queue_free()
	self.modulate = Color(10, 10, 10, 1)
	await get_tree().create_timer(0.1).timeout
	self.modulate = Color(1,1,1,1)
	

func _physics_process(delta):
	var player: CharacterBody2D = get_node("/root/Node2D/Player")
	# We assume the zombie and the player are siblings of the same node, so a 
	# direct position comparison is warranted.
	var direction = (player.position - self.position).normalized()
	velocity = direction * speed * delta

	move_and_slide()
