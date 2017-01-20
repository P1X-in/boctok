extends RigidBody2D


var ROTATE_STEP = 6
var ROTATE_THRESHOLD = 6.28

var ACCELERATION = 500

var GRAVITY_FACTOR = 10000000000

var rotation = 0
var current_acceleration = Vector2(0, 0)
var thrust = preload("res://scenes/thrust.tscn")
var thrust_node = null

func _integrate_forces(s):
    var lv = s.get_linear_velocity()
    var step = s.get_step()

    var rotate_left = Input.is_action_pressed('rotate_left')
    var rotate_right = Input.is_action_pressed('rotate_right')
    var accelerate = Input.is_action_pressed('accelerate')

    if rotate_left and not rotate_right:
        self.rotation = self.rotation + self.ROTATE_STEP * step
        if self.rotation > self.ROTATE_THRESHOLD:
            self.rotation = self.rotation - self.ROTATE_THRESHOLD
    elif rotate_right and not rotate_left:
        self.rotation = self.rotation - self.ROTATE_STEP * step
        if self.rotation < 0:
            self.rotation = self.rotation + self.ROTATE_THRESHOLD

    self.set_rot(self.rotation)

    var acceleration_vector = Vector2(0,-1).rotated(self.rotation)

    if accelerate:
        lv = lv + acceleration_vector * self.ACCELERATION * step
        self.thrust_node.set_emitting(true)
    lv += s.get_total_gravity() * step * self.GRAVITY_FACTOR
    self.current_acceleration = lv
    s.set_linear_velocity(lv)


func _ready():
    self.set_mode(self.MODE_CHARACTER)
    self.thrust_node = self.get_node("Thrust")
    print('ready')
