extends Marker2D


@onready var gun_sprite = $Gun/Sprite2D;

func _process(delta):
	look_at(get_global_mouse_position())
	
	
func _on_player_look_direction_changed(direction):
	print(direction)
	gun_sprite.scale.y = gun_sprite.scale.y * direction;
	print(gun_sprite.scale)
