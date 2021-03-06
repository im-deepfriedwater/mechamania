extends KinematicBody

const MOVE_SPEED = 12
const JUMP_FORCE = 30
const GRAVITY = 0.98
const MAX_FALL_SPEED = 30

const H_LOOK_SENS = 1.0
const V_LOOK_SENS = 1.0

onready var cam = $CamBase
onready var anim = $Graphics/AnimationPlayer

var y_velo = 0


func _ready():
#	anim.get_animation("walk").set_loop(true)
	pass
	
	
func _input(event):
	if event is InputEventMouseMotion:
		cam.rotation_degrees.x -= event.relative.y * V_LOOK_SENS
		cam.rotation_degrees.x = clamp(cam.rotation_degrees.x, -90, 90)
		rotation_degrees.y -= event.relative.x * H_LOOK_SENS
		
func _physics_process(delta: float) -> void:
	var move_vec = Vector3()
	
	if Input.is_action_pressed("forward"):
		move_vec.z -= 1
	if Input.is_action_pressed("backwards"):
		move_vec.z += 1
	if Input.is_action_pressed("left"):
		move_vec.x -= 1
	if Input.is_action_pressed("right"):
		move_vec.x += 1
	
	move_vec = move_vec.normalized()
	move_vec = move_vec.rotated(Vector3.UP, rotation.y)
	move_vec *= MOVE_SPEED
	move_vec.y = y_velo
	
	move_and_slide(move_vec, Vector3.UP)\
	
	y_velo -= GRAVITY
	
	var jumped = false
	var grounded = is_on_floor()
	
	if grounded and Input.is_action_just_pressed("jump"):
		jumped = true
		y_velo = JUMP_FORCE
	
	if grounded and y_velo <= 0:
		y_velo = -0.1
	
	if y_velo < -MAX_FALL_SPEED:
		y_velo = -MAX_FALL_SPEED
	
	if jumped:
#		play_anim("jump
		pass
	elif grounded:
		if move_vec.x == 0 and move_vec.z == 0:
#			play_anim("idle")
			pass
		else:
#			play_anim("walk")
			pass
		

func play_anim(name):
	if anim.current_animation == name:
		return
	
	anim.play(name)
		
  
