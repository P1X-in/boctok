extends "res://scripts/input/handlers/abstract_handler.gd"

var bag

func can_handle(event):
    return true

func handle(event):
    self.bag.intro.detach()
    self.bag.board.attach()
    self.bag.input.switch_to_scheme("game")
    self.bag.players.spawn_players()

func _init(bag):
    self.bag = bag
