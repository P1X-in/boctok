
var bag
var container
var screen_scene

func _init_bag(bag, container):
    self.bag = bag
    self.container = container

func attach():
    if self.container.is_a_parent_of(self.screen_scene):
        return
    self.container.add_child(self.screen_scene)

func detach():
    if !self.container.is_a_parent_of(self.screen_scene):
        return
    self.container.remove_child(self.screen_scene)