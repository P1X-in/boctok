extends "res://scripts/input/handlers/gamepad_handler.gd"

var bag
var player

func _init(bag, player, button):
    self.bag = bag
    self.player = player
    self.type = InputEvent.JOYSTICK_BUTTON
    self.button_index = button

func handle(event):
    self.player.swear()
