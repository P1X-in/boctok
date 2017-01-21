extends "res://scripts/entities/object.gd"

var camera

var player_id
var gamepad_id = null
var keyboard_use = null

var gamepad_handlers = []
var keyboard_handlers = []

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
    ]

    self.keyboard_handlers = [
        preload("res://scripts/input/handlers/player_rotate_key.gd").new(self.bag, self, KEY_LEFT, 1),
        preload("res://scripts/input/handlers/player_rotate_key.gd").new(self.bag, self, KEY_RIGHT, -1),
        preload("res://scripts/input/handlers/player_accelerate_key.gd").new(self.bag, self, KEY_UP),
        preload("res://scripts/input/handlers/player_boost_key.gd").new(self.bag, self, KEY_DOWN),
    ]

func attach():
    .attach()

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
    return

func bind_camera(viewport):
    self.camera.set_custom_viewport(viewport)
