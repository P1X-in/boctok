extends "res://scripts/entities/object.gd"

var camera
var hud

var player_id
var gamepad_id = null
var keyboard_use = null

var gamepad_handlers = []
var keyboard_handlers = []


var rocket_template = preload("res://scenes/ships/rocket.tscn")
var rocket_cooldown = false
var rocket_firing = false
var ROCKET_COOLDOWN_TIME = 0.1

func _init(bag, player_id).(bag):
    self.bag = bag
    self.player_id = player_id
    self.avatar = preload("res://scenes/ships/ship.tscn").instance()
    self.camera = self.avatar.get_node('camera')

    self.gamepad_handlers = [
        preload("res://scripts/input/handlers/player_rotate_axis.gd").new(self.bag, self, 0),
        #preload("res://scripts/input/handlers/player_accelerate_axis.gd").new(self.bag, self, 1),
        #preload("res://scripts/input/handlers/player_accelerate_axis.gd").new(self.bag, self, 3),
        preload("res://scripts/input/handlers/player_accelerate_button.gd").new(self.bag, self, JOY_BUTTON_0),
        preload("res://scripts/input/handlers/player_boost_button.gd").new(self.bag, self, JOY_BUTTON_1),
        preload("res://scripts/input/handlers/rocket_launch_button.gd").new(self.bag, self, JOY_BUTTON_2),
        preload("res://scripts/input/handlers/rocket_launch_trigger.gd").new(self.bag, self, 4),
        preload("res://scripts/input/handlers/rocket_launch_trigger.gd").new(self.bag, self, 5),
        preload("res://scripts/input/handlers/rocket_launch_trigger.gd").new(self.bag, self, 6),
        preload("res://scripts/input/handlers/rocket_launch_trigger.gd").new(self.bag, self, 7),
    ]

    self.keyboard_handlers = [
        preload("res://scripts/input/handlers/player_rotate_key.gd").new(self.bag, self, KEY_LEFT, 1),
        preload("res://scripts/input/handlers/player_rotate_key.gd").new(self.bag, self, KEY_RIGHT, -1),
        preload("res://scripts/input/handlers/player_accelerate_key.gd").new(self.bag, self, KEY_UP),
        preload("res://scripts/input/handlers/player_boost_key.gd").new(self.bag, self, KEY_DOWN),
        preload("res://scripts/input/handlers/rocket_launch_key.gd").new(self.bag, self, KEY_SPACE),
    ]

func spawn(initial_position):
    self.attach()
    self.avatar.set_pos(initial_position)

func attach():
    self.bag.processing.register(self)
    .attach()

func detach():
    self.bag.processing.remove(self)
    .detach()

func bind_keyboard():
    var keyboard = self.bag.input.schemes['game']['keyboard']
    self.keyboard_use = true
    for handler in self.keyboard_handlers:
        keyboard.register_handler(handler)
func unbind_keyboard():
    if not self.keyboard_use:
        return

    var keyboard = self.bag.input.schemes['game']['keyboard']
    self.keyboard_use = false
    for handler in self.keyboard_handlers:
        keyboard.remove_handler(handler)

func bind_gamepad(id):
    self.unbind_gamepad()
    self.gamepad_id = id
    var gamepad = self.bag.input.schemes['game']['pad' + str(id)]

    for handler in self.gamepad_handlers:
        gamepad.register_handler(handler)

func unbind_gamepad():
    if self.gamepad_id == null:
        return

    var gamepad = self.bag.input.schemes['game']['pad' + str(self.gamepad_id)]

    for handler in self.gamepad_handlers:
        gamepad.remove_handler(handler)

    self.gamepad_id = null

func reset():
    self.rocket_cooldown = false
    self.rocket_firing = false
    self.avatar.reset()

func bind_camera(viewport):
    self.camera.set_custom_viewport(viewport)

func bind_hud(hud):
    self.hud = hud

func process(delta):
    hud.update_sun_indicator(self.avatar.get_pos())
    hud.update_fuel(self.avatar.fuel)
    hud.update_gravity(self.avatar.current_gravity)
    hud.update_ship_velocity(self.avatar.current_acceleration)
    hud.update_sun_warning(self)

    if self.rocket_firing and not self.rocket_cooldown:
        self.fire_rocket()


func fire_rocket():
    if self.rocket_cooldown:
        return

    var rocket = self.rocket_template.instance()
    var position = self.avatar.get_pos()
    var rocket_offset = Vector2(0, -1).rotated(self.avatar.rotation)
    var rocket_position = position + rocket_offset * 60

    rocket.initial_velocity = self.avatar.current_acceleration + rocket_offset * 500

    self.bag.board.attach_object(rocket)
    rocket.set_pos(rocket_position)
    rocket.set_rot(rocket.initial_velocity.angle() + 3.14)

    self.rocket_cooldown = true
    self.bag.timers.set_timeout(self.ROCKET_COOLDOWN_TIME, self, "rocket_cooldown_done")

func rocket_cooldown_done():
    self.rocket_cooldown = false
