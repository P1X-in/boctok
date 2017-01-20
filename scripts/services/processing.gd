
var bag
var container
var wrapper_template = preload("res://scripts/services/processing_wrapper.gd")

var ready = false

var objects = {}

func _init_bag(bag, container):
    self.bag = bag
    self.container = container
    self.ready = true

func register(object):
    var wrapper = self.wrapper_template.new(self, object)
    self.objects[object.get_instance_ID()] = wrapper
    self.container.add_child(wrapper)

func remove(object):
    if not self.objects.has(object.get_instance_ID()):
        return

    var wrapper = self.objects[object.get_instance_ID()]
    wrapper.kill()
    self.container.remove_child(wrapper)
    self.objects.erase(object.get_instance_ID())

func reset():
    var wrapper
    for id in self.objects:
        wrapper = self.objects[id]
        self.container.remove_child(wrapper)
        wrapper.kill()
    self.objects.clear()

