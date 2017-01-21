extends Control

const FUEL_GRANTED = 10
const DISTANCE_LIMIT = 1500
const KILL_LIMIT = 2500

var bag

func _fixed_process(delta):
    var distance
    for player in self.bag.players.players:
        distance = player.avatar.get_pos().distance_to(self.get_pos())
        if distance < self.DISTANCE_LIMIT:
            player.avatar.fuel += self.FUEL_GRANTED * delta
            if player.avatar.fuel > player.avatar.MAX_FUEL:
                player.avatar.fuel = player.avatar.MAX_FUEL
        elif distance > self.KILL_LIMIT:
            player.detach()


func _ready():
    self.set_fixed_process(true)
    self.bag = self.get_node("/root/boctok").bag