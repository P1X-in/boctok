extends "res://scripts/input/handlers/keyboard_handler.gd"

var bag
var player

func _init(bag, player, key):
    self.bag = bag
    self.player = player
    self.scancode = key

func handle(event):
    self.player.swear()
