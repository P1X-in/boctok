
var bag = preload("res://scripts/bag.gd").new()

func _input(event):
    self.bag.input.handle_event(event)


func _ready():
    self.bag._init_bag(self)
    self.set_process_input(true)

    self.bag.intro.attach()
    self.bag.sound.play_soundtrack("menu")