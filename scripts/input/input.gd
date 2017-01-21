
var bag

var keyboard_template = preload("res://scripts/input/keyboard.gd")
var gamepad_template = preload("res://scripts/input/gamepad.gd")
var mouse_template = preload("res://scripts/input/mouse.gd")
var arcade_template = preload("res://scripts/input/arcade.gd")
var any_device_template = preload("res://scripts/input/any_device.gd")

var schemes = {
    "intro" : {
        "any" : self.any_device_template.new(),
    },
    "over" : {
        "keyboard" : self.keyboard_template.new(),
        "any" : self.any_device_template.new(),
    },
    "game" : {
        "keyboard" : self.keyboard_template.new(),
        "pad0" : self.gamepad_template.new(0),
        "pad1" : self.gamepad_template.new(1),
        "pad2" : self.gamepad_template.new(2),
        "pad3" : self.gamepad_template.new(3),
    }
}

var active_scheme = "intro"

func _init_bag(bag):
    self.bag = bag
    self.load_basic_input()

func handle_event(event):
    for device in self.schemes[self.active_scheme]:
        if self.schemes[self.active_scheme][device].can_handle(event):
            self.schemes[self.active_scheme][device].handle_event(event)

func switch_to_scheme(scheme):
    self.active_scheme = scheme

func load_basic_input():
    self.schemes['intro']['any'].register_handler(preload("res://scripts/input/handlers/skip_intro_handler.gd").new(self.bag))
    self.schemes['game']['keyboard'].register_handler(preload("res://scripts/input/handlers/quit_game.gd").new())
    self.schemes['over']['keyboard'].register_handler(preload("res://scripts/input/handlers/quit_game.gd").new())
    self.schemes['over']['any'].register_handler(preload("res://scripts/input/handlers/restart_game_any.gd").new(self.bag))

