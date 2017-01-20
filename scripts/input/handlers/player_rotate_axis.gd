extends "res://scripts/input/handlers/gamepad_handler.gd"

var bag
var player

func _init(bag, player, axis):
    self.bag = bag
    self.player = player
    self.type = InputEvent.JOYSTICK_MOTION
    self.axis = axis

func handle(event):
    if self.bag.action.is_game_in_progress && self.player.is_playing && self.player.is_alive:
        self.player.controller_vector[self.axis] = min(event.value * 2, 1)