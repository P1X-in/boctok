extends "res://scripts/input/handlers/keyboard_handler.gd"

var bag
var player
var direction

func _init(bag, player, key, direction):
    self.bag = bag
    self.player = player
    self.scancode = key
    self.direction = direction

func handle(event):
    if event.is_echo():
        return

    self.player.avatar.do_rotate = event.is_pressed()
    self.player.avatar.rotate_factor = self.direction