extends "res://scripts/input/handlers/abstract_handler.gd"

var bag

func can_handle(event):
    return true

func handle(event):
    self.bag.input.switch_to_scheme("game")
    self.bag.timers.set_timeout(3, self, "_perform_restart")

func _perform_restart():
    self.bag.board.reset()
    self.bag.players.spawn_players()

func _init(bag):
    self.bag = bag
