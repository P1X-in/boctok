extends RigidBody2D

var GRAVITY_FACTOR = 100000000000

var launch_acceleration = Vector2(1, 0)

var current_acceleration = Vector2(0, 0)
var current_gravity = Vector2(0, 0)

func _integrate_forces(s):
    var lv = s.get_linear_velocity()
    var step = s.get_step()

    self.set_rot(lv.angle())

    self.current_gravity = s.get_total_gravity() * step * self.GRAVITY_FACTOR
    lv += self.current_gravity
    self.current_acceleration = lv

    s.set_linear_velocity(lv)

func _colliding_body(body):
    print('boom')
    self.queue_free()

func _ready():
    set_fixed_process(true)
