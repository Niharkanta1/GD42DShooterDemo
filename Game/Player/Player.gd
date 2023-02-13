extends CharacterBody2D

class_name  Player

@onready var sprite : Sprite2D = $Body/Sprite2D;
@onready var animation_player : AnimationPlayer = $Body/AnimationPlayer;
@onready var gun_position : Marker2D = $GunPosition

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


func _physics_process(delta):
	UpdateLookDirection();
	UpdateGunPosition();
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

			# Other State Transitions:
			if is_equal_approx(input_direction_x, 0.0) and is_equal_approx(input_direction_y, 0.0):
				state = states.IDLE

		states.DASH:
			pass;

		states.DIE:
			pass;
			
			
func UpdateLookDirection() -> void:
	var pointer = get_global_mouse_position();
	var pointer_direction = position.x - pointer.x;
	if pointer_direction < 0:
		if not direction == 1: 
			direction = 1;
			sprite.flip_h = false;
			emit_signal("look_direction_changed", direction);
		
	elif pointer_direction > 0:
		if not direction == -1: 
			direction = -1;
			sprite.flip_h = true;
			emit_signal("look_direction_changed", direction);
	

func UpdateGunPosition() -> void:
	pass;



















