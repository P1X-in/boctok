extends Control

var bag

var particle

func _ready():
    self.bag = self.get_node("/root/boctok").bag
    self.particle = self.get_node("Particles2D")
    self.particle.set_emitting(true)

    self.bag.timers.set_timeout(1, self, 'queue_free')
