extends CharacterBody2D

class_name  Player

@onready var sprite : Sprite2D = $Body/Sprite2D;
@onready var animation_player : AnimationPlayer = $Body/AnimationPlayer;
@onready var gun_position : Marker2D = $GunPosition
@onready var gun: Gun = $GunPosition/Gun

@export var move_speed: float = 100;

signal look_direction_changed(direction);

enum states {
	IDLE,
	MOVE,
	DASH,
	DIE
}

var direction: int = 1;
var aim_direction : Vector2;

var state: states = states.IDLE:
	set(value):
		match value:
			states.IDLE:
				animation_player.play("_idle");

			states.MOVE:
				animation_player.play("_move");

			states.DIE:
				pass

		state = value;
	get:
		return state;


func _ready():
	state = states.IDLE;


func _physics_process(_delta):
	update_look_direction();
	match state:
		states.IDLE:
			if Input.is_action_pressed("left") or Input.is_action_pressed("right") or \
				Input.is_action_pressed("up") or Input.is_action_pressed("down"):
				state = states.MOVE;

		states.MOVE:
			var input_direction_x: float = Input.get_axis("left", "right");
			var input_direction_y: float = Input.get_axis("up", "down");

			if Input.is_action_pressed("right") && Input.is_action_pressed("left"):
				if direction == 1:
					input_direction_x = 1;
				else:
					input_direction_x = -1;

			velocity = Vector2(input_direction_x, input_direction_y);
			velocity = velocity.normalized() * move_speed;
			move_and_slide()
			check_back_ward_movement(input_direction_x);

			# Other State Transitions:
			if is_equal_approx(input_direction_x, 0.0) and is_equal_approx(input_direction_y, 0.0):
				state = states.IDLE

		states.DASH:
			pass;

		states.DIE:
			pass;
	
	# need to call at the end so that the shoot position will be sync with latest position of player
	fire_weapon(); 
	
	
	
func update_look_direction() -> void:
	if get_local_mouse_position().x > 0:
		if not direction == 1: 
			direction = 1;
			sprite.flip_h = false;
		
	elif get_local_mouse_position().x < 0:
		if not direction == -1: 
			direction = -1;
			sprite.flip_h = true;
			

func check_back_ward_movement(input_direction: int) -> void:
	if direction != input_direction:
		animation_player.speed_scale = -1;
	else:
		animation_player.speed_scale = 1;


func fire_weapon() -> void:
	if(Input.is_action_just_pressed("fire")):
		gun.shootBullet();
		
















