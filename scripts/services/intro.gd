extends "res://scripts/services/abstract_screen.gd"

func _init():
    self.screen_scene = preload("res://scenes/intro/intro.tscn").instance()

func _init_bag(bag, container):
    ._init_bag(bag, container)
