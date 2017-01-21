extends "res://scripts/input/handlers/keyboard_handler.gd"

var bag
var player

func _init(bag, player, key):
    self.bag = bag
    self.player = player
    self.scancode = key

func handle(event):
    if event.is_echo():
        return

    self.player.avatar.accelerate = event.is_pressed()
    self.player.avatar.accelerate_factor = 1