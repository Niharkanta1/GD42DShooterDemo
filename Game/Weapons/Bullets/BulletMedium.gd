extends Area2D

class_name Bullet

@export var damage: float = 1;
@export var speed: float = 250;

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready():
	animated_sprite.play("_travel")


func _physics_process(delta):
	move_local_x(delta * speed);
