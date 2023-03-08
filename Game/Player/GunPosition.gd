extends Marker2D


@onready var gun_sprite = $Gun/Sprite2D;

func _process(_delta):
	look_at(get_global_mouse_position())
	if (get_parent().get_local_mouse_position().x < 0):
		flipVertical(true)
	else :
		flipVertical(false)	


func flipVertical(flip):
	gun_sprite.flip_v = flip
	
	if flip:
		gun_sprite.position.y = -2
	else :
		gun_sprite.position.y = 0
