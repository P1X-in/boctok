
var bag = preload("res://scripts/bag.gd").new()

func _ready():
    self.bag._init_bag(self)
