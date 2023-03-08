extends Node2D

class_name Gun

@export var bullet = preload("res://Game/Weapons/Bullets/BulletMedium.tscn");

@onready var shoot_position: Marker2D = $ShootPosition

func shootBullet():
	var obj = bullet.instantiate();
	obj.set_position(shoot_position.global_position);
	obj.set_rotation(get_parent().global_rotation);
	owner.owner.add_child(obj);
	
