extends "res://scripts/input/handlers/gamepad_handler.gd"

var bag
var player

func _init(bag, player, axis):
    self.bag = bag
    self.player = player
    self.type = InputEvent.JOYSTICK_MOTION
    self.axis = axis

func handle(event):
    if event.value < -0.1:
        self.player.avatar.accelerate = true
        self.player.avatar.accelerate_factor = -event.value
    else:
        self.player.avatar.accelerate = false
        self.player.avatar.accelerate_factor = 0
