extends "res://scripts/services/abstract_screen.gd"

var viewport_left
var hud_left
var newspaper_left
var viewport_right
var hud_right
var newspaper_right

var attached_objects = {}
var current_map = null

var mount
var ready = true

func _init():
    self.screen_scene = preload("res://scenes/board.tscn").instance()
    self.viewport_left = self.screen_scene.get_node('left/Viewport')
    self.hud_left = self.screen_scene.get_node('left/hud/anchor/panel')
    self.newspaper_left = self.screen_scene.get_node('left/newspaper')
    self.viewport_right = self.screen_scene.get_node('right/Viewport')
    self.hud_right = self.screen_scene.get_node('right/hud/anchor/panel')
    self.newspaper_right = self.screen_scene.get_node('right/newspaper')

    self.mount = self.viewport_left.get_node('mount')
    self.current_map = self.mount.get_node('space')

    self.viewport_right.set_world_2d(self.viewport_left.get_world_2d())

func reset():
    #self.clear_all_objects()
    self.ready = true


func attach_object(object):
    if self.current_map == null or not self.mount.is_a_parent_of(self.current_map) or self.current_map.is_a_parent_of(object):
        return

    self.attached_objects[object.get_instance_ID()] = object
    self.current_map.add_child(object)

func detach_object(object):
    if self.current_map == null or not self.mount.is_a_parent_of(self.current_map) or not self.current_map.is_a_parent_of(object):
        return

    self.attached_objects.erase(object.get_instance_ID())
    self.current_map.remove_child(object)

func clear_all_objects():
    for object in self.attached_objects:
        self.current_map.remove_child(self.attached_objects[object])
    self.attached_objects.clear()



func end_game(looser):
    if not self.ready:
        return

    self.ready = false
    self.bag.players.despawn_players()
    self.bag.players.reset()
    self.bag.input.switch_to_scheme("over")
    looser.show_fail()
    self.bag.sound.play('ship_die')
