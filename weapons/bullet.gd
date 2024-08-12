class_name Bullet
extends Area2D

var direction: Vector2 = Vector2.RIGHT

@export var speed = 10
@export var damage = 5.0
@export var lifetime_sec = 1.0

func _ready():
	# Exist in the bullet layer (3)
	collision_layer = 0b00000000_00000000_00000000_00000100
	# Only detect collisions with enemies (2)
	collision_mask  = 0b00000000_00000000_00000000_00000010

	monitoring = true
	self.body_entered.connect(self._handle_body_entered)

	# Expire this bullet.
	get_tree().create_timer(lifetime_sec).timeout.connect(self.queue_free)

func _handle_body_entered(body: Node2D):
	if not(body is Monster):
		return
	var monster: Monster = body
	monster.receive_damage(self.damage)
	self.queue_free()

func _physics_process(delta):
	var velocity = direction*speed*delta
	self.position += velocity

