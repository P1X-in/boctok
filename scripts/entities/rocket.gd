extends RigidBody2D

var bag
var ship = preload("res://scripts/ship.gd")

var GRAVITY_FACTOR = 100000000000

var current_acceleration = Vector2(0, 0)
var current_gravity = Vector2(0, 0)

var initial_velocity = Vector2(0, 0)
var started = false

var engines = []

var owner


func _integrate_forces(s):
    var pos = self.get_pos()

    if pos.distance_to(Vector2(5000, 5000)) > 3000:
        self.queue_free()

    var lv = s.get_linear_velocity()
    var step = s.get_step()

    var engines_on = {"Main" : true, "Left": false, "Right" : false}

    self.set_rot(lv.angle() + 3.14)

    self.current_gravity = s.get_total_gravity() * step * self.GRAVITY_FACTOR
    lv += self.current_gravity
    self.current_acceleration = lv

    if not self.started:
        lv += self.initial_velocity
        self.started = true

    s.set_linear_velocity(lv)
    self.__engines_start(engines_on)

func _colliding_body(body):
    if body extends self.ship and body.player_id != self.owner:
        self.bag.players.players[self.owner].score += 10
    self.bag.sound.play('rocket_bang')
    self.bag.board.add_explosion(self.get_pos())
    self.queue_free()

func __engines_start(engines):
    for engine in engines:
        if engines[engine] == true:
            self.engines[engine].set_emitting(true)

func _ready():
    self.bag = self.get_node("/root/boctok").bag
    set_fixed_process(true)
    var engines = self.get_node("Engines")
    self.engines = {
        "Main" : engines.get_node("Main"),
        "Left" : engines.get_node("Left"),
        "Right" : engines.get_node("Right"),
    }
