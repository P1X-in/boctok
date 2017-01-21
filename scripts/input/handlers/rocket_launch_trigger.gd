extends "res://scripts/input/handlers/gamepad_handler.gd"

var bag
var player

func _init(bag, player, axis):
    self.bag = bag
    self.player = player
    self.type = InputEvent.JOYSTICK_MOTION
    self.axis = axis

func handle(event):
    if event.value > 0.3:
        self.player.rocket_firing = true
    else:
        self.player.rocket_firing = false
