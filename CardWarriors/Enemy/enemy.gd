extends CharacterBody2D

@export var movement_speed = 20.0
@export var hp = 10

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $AnimatedSprite2D
@onready var deathAnimTimer = $AnimatedSprite2D/DeathAnimTimer

func _ready():
	sprite.play("default")

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movement_speed
	move_and_slide()
	
	if direction.x < 0.1:
		sprite.flip_h = true
	elif direction.x > -0.1:
		sprite.flip_h = false


func _on_hurt_box_hurt(damage):
	hp -= damage
	if hp <= 0:
		sprite.play("death")
		deathAnimTimer.start()
		


func _on_death_anim_timer_timeout():
	queue_free()
