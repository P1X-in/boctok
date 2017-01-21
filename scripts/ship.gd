extends RigidBody2D

var ROTATE_STEP = 6
var ROTATE_THRESHOLD = 6.28

var ACCELERATION = 300
var BOOST = 1500
var BOOST_FUEL = 6

var GRAVITY_FACTOR = 100000000000
var MAX_FUEL = 100

var rotation = 0
var current_acceleration = Vector2(0, 0)
var current_gravity = Vector2(0, 0)

var engines = []

var fuel = 100

var do_rotate = false
var rotate_factor = 1
var accelerate = false
var accelerate_factor = 1
var boost = false

func _integrate_forces(s):
    var lv = s.get_linear_velocity()
    var step = s.get_step()

    var engines_on = {"Main" : false, "Left": false, "Right" : false}

    if self.do_rotate:
        self.rotation = self.rotation + self.ROTATE_STEP * step * self.rotate_factor
        if self.rotation > self.ROTATE_THRESHOLD:
            self.rotation = self.rotation - self.ROTATE_THRESHOLD
        if self.rotation < 0:
            self.rotation = self.rotation + self.ROTATE_THRESHOLD
        if self.rotate_factor < 0:
            engines_on["Left"] = true
        elif self.rotate_factor > 0:
            engines_on["Right"] = true
    self.set_rot(self.rotation)

    var acceleration_vector = Vector2(0,-1).rotated(self.rotation)

    if self.accelerate and self.fuel > step * 10:
        lv = lv + acceleration_vector * self.ACCELERATION * step * self.accelerate_factor
        engines_on["Main"] = true
        self.fuel = self.fuel - step * 10
    elif self.boost and self.fuel > step * 10 * self.BOOST_FUEL:
        lv = lv + acceleration_vector * self.BOOST * step
        engines_on["Main"] = true
        engines_on["Left"] = true
        engines_on["Right"] = true
        self.fuel = self.fuel - step * 10 * self.BOOST_FUEL
    #elif self.fuel < 10:
    #    self.fuel = self.fuel + step * 20
    #    if self.fuel > 10:
    #        self.fuel = 10

    self.current_gravity = s.get_total_gravity() * step * self.GRAVITY_FACTOR
    lv += self.current_gravity
    self.current_acceleration = lv
    self.__engines_start(engines_on)
    s.set_linear_velocity(lv)

func __engines_start(engines):
    for engine in engines:
        if engines[engine] == true:
            self.engines[engine].set_emitting(true)

func _ready():
    self.set_mode(self.MODE_CHARACTER)
    var engines = self.get_node("Engines")
    self.engines = {
        "Main" : engines.get_node("Main"),
        "Left" : engines.get_node("Left"),
        "Right" : engines.get_node("Right"),
    }
