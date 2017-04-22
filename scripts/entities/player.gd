extends "res://scripts/entities/object.gd"

var camera
var hud
var fuel_gauge
var newspaper

var player_id
var gamepad_id = null
var keyboard_use = null

var gamepad_handlers = []
var keyboard_handlers = []

var boctok_template = preload("res://scenes/ships/ship.tscn")
var mercury_template = preload("res://scenes/ships/mercury.tscn")

var rocket_template = preload("res://scenes/ships/rocket.tscn")
var rocket_cooldown = false
var swear_cooldown = false
var rocket_firing = false
var ROCKET_COOLDOWN_TIME = 0.1
var SWEAR_COOLDOWN_TIME = 2

var score = 0

func _init(bag, player_id).(bag):
    self.bag = bag
    self.player_id = player_id
    if player_id == 0:
        self.avatar = self.boctok_template.instance()
    else:
        self.avatar = self.mercury_template.instance()
    self.avatar.player_id = player_id
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
        preload("res://scripts/input/handlers/swear_button.gd").new(self.bag, self, JOY_BUTTON_3),

    ]

    self.keyboard_handlers = [
        preload("res://scripts/input/handlers/player_rotate_key.gd").new(self.bag, self, KEY_LEFT, 1),
        preload("res://scripts/input/handlers/player_rotate_key.gd").new(self.bag, self, KEY_RIGHT, -1),
        preload("res://scripts/input/handlers/player_accelerate_key.gd").new(self.bag, self, KEY_UP),
        preload("res://scripts/input/handlers/player_boost_key.gd").new(self.bag, self, KEY_DOWN),
        preload("res://scripts/input/handlers/rocket_launch_key.gd").new(self.bag, self, KEY_SPACE),
        preload("res://scripts/input/handlers/swear_key.gd").new(self.bag, self, KEY_B),
    ]

func spawn(initial_position):
    self.attach()
    self.avatar.set_pos(initial_position)

func attach():
    self.bag.processing.register(self)
    self.newspaper.hide()
    self.hud.show()
    self.fuel_gauge.show()
    self.score = 0
    .attach()

func detach():
    self.bag.processing.remove(self)
    self.hud.hide()
    self.fuel_gauge.hide()
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
    self.score = 0

func bind_camera(viewport):
    self.camera.set_custom_viewport(viewport)

func bind_hud(hud, fuel_gauge):
    self.hud = hud
    self.fuel_gauge = fuel_gauge

func bind_newspaper(newspaper):
    self.newspaper = newspaper

func show_fail():
    self.newspaper.show()
    self.newspaper.get_node('victory').hide()
    if self.player_id == 0:
        self.newspaper.get_node('nyt').hide()
        self.newspaper.get_node('pravda').show()
    else:
        self.newspaper.get_node('nyt').show()
        self.newspaper.get_node('pravda').hide()

func show_win():
    self.newspaper.show()
    self.newspaper.get_node('victory').show()
    self.newspaper.get_node('nyt').hide()
    self.newspaper.get_node('pravda').hide()

func process(delta):
    self.hud.update_sun_indicator(self.avatar.get_pos())
    self.hud.update_fuel(self.avatar.fuel)
    self.fuel_gauge.update_fuel(self.avatar.fuel)
    self.hud.update_gravity(self.avatar.current_gravity)
    self.hud.update_ship_velocity(self.avatar.current_acceleration)
    self.hud.update_score(self.score)

    if hud.update_sun_warning(self):
        self.swear()

    if self.rocket_firing and not self.rocket_cooldown:
        self.fire_rocket()

func fire_rocket():
    if self.rocket_cooldown:
        return

    var rocket = self.rocket_template.instance()
    var position = self.avatar.get_pos()
    var starting_vector = Vector2(0, -1)
    starting_vector.x = ((randi() % 101) - 50) / 900.0
    var rocket_offset = starting_vector.rotated(self.avatar.rotation)
    var rocket_position = position + rocket_offset * 60

    rocket.initial_velocity = self.avatar.current_acceleration + rocket_offset * 500

    self.bag.board.attach_object(rocket)
    rocket.set_pos(rocket_position)
    rocket.set_rot(rocket.initial_velocity.angle() + 3.14)

    self.rocket_cooldown = true
    self.bag.timers.set_timeout(self.ROCKET_COOLDOWN_TIME, self, "rocket_cooldown_done")

    rocket.owner = self.player_id
    self.bag.sound.play('rocket_launch')

func rocket_cooldown_done():
    self.rocket_cooldown = false

func swear_cooldown_done():
    self.swear_cooldown = false

func swear():
    if self.swear_cooldown:
        return

    randomize()
    var suffix
    var item
    if self.player_id == 0:
        suffix = "ru_"
    else:
        suffix = "en_"
    item = 'swear_' + suffix + str(randi() % 8 + 1)

    self.bag.sound.play(item)

    self.swear_cooldown = true
    self.bag.timers.set_timeout(self.SWEAR_COOLDOWN_TIME, self, "swear_cooldown_done")

