extends "res://scripts/input/handlers/gamepad_handler.gd"

var bag
var player

func _init(bag, player, axis):
    self.bag = bag
    self.player = player
    self.type = InputEvent.JOYSTICK_MOTION
    self.axis = axis

func handle(event):
    if abs(event.value) > 0.1:
        self.player.avatar.do_rotate = true
    else:
        self.player.avatar.do_rotate = false
    self.player.avatar.rotate_factor = -event.value
