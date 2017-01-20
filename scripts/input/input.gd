
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
    "menu" : {
        "keyboard" : self.keyboard_template.new(),
        "pad0" : self.gamepad_template.new(0),
        "pad1" : self.gamepad_template.new(1),
        "pad2" : self.gamepad_template.new(2),
        "pad3" : self.gamepad_template.new(3),
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


#    self.devices['keyboard'].register_handler(preload("res://scripts/input/handlers/start_game_key.gd").new(self#.bag))#
#    self.devic#es['keyboard'].register_handler(preload("res://scripts/input/handlers/#player#_enter_game_keyboard.gd").new(self.bag))#
#
#    var device
#    var start_game_handler = preload("res://scripts/input/handlers/start_game_gamepad.gd").new(self.bag)
#    var enter_game_handler = preload("res://scripts/input/handlers/player_enter_game_gamepad.gd").new(self.bag)
#    for device_id in self.devices:
#        device = self.devices[device_id]
#        if device extends self.gamepad_template:
#            device.register_handler(start_game_handler)
#            device.register_handler(enter_game_handler)
