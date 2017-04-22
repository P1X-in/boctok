extends "res://scripts/services/abstract_screen.gd"

var viewport_left
var hud_left
var newspaper_left
var fuel_gauge_left
var tracker_left
var score_big_left

var viewport_right
var hud_right
var newspaper_right
var fuel_gauge_right
var tracker_right
var score_big_right

var game_timer

var attached_objects = {}
var current_map = null

var mount
var ready = true

var explosion_template = preload("res://particles/explosion.tscn")

func _init():
    self.screen_scene = preload("res://scenes/board.tscn").instance()

    self.viewport_left = self.screen_scene.get_node('left/Viewport')
    self.hud_left = self.screen_scene.get_node('left/hud/anchor/panel')
    self.newspaper_left = self.screen_scene.get_node('left/newspaper')
    self.fuel_gauge_left = self.screen_scene.get_node('left/hud_side/anchor/fuel')
    self.tracker_left = self.screen_scene.get_node('left/frame/game/arrow')
    self.score_big_left = self.screen_scene.get_node('left/frame/top/contener/box2/score')
    self.hud_left.add_big_score(self.score_big_left)

    self.viewport_right = self.screen_scene.get_node('right/Viewport')
    self.hud_right = self.screen_scene.get_node('right/hud/anchor/panel')
    self.newspaper_right = self.screen_scene.get_node('right/newspaper')
    self.fuel_gauge_right = self.screen_scene.get_node('right/hud_side/anchor/fuel')
    self.tracker_right = self.screen_scene.get_node('right/frame/game/arrow')
    self.score_big_right = self.screen_scene.get_node('right/frame/top/contener/box2/score')
    self.hud_right.add_big_score(self.score_big_right)

    self.game_timer = self.screen_scene.get_node('top_center/anchor/timer/time')

    self.mount = self.viewport_left.get_node('mount')
    self.current_map = self.mount.get_node('space')

    self.viewport_right.set_world_2d(self.viewport_left.get_world_2d())

func _init_bag(bag, root):
    ._init_bag(bag, root)
    self.game_timer._init_bag(bag)

func reset():
    #self.clear_all_objects()
    self.ready = true
    self.show_trackers()
    self.game_timer.reset()


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


func start_game():
    self.reset()
    self.bag.players.spawn_players()
    self.game_timer.start_timer()

func end_game(looser):
    if not self.ready:
        return

    self.hide_trackers()
    if looser != null:
        self.bag.sound.play('ship_die')
        self.add_explosion(looser.get_pos())
    self.ready = false
    self.bag.players.despawn_players()
    self.bag.players.reset()
    self.bag.input.switch_to_scheme("over")
    if looser != null:
        self.bag.players.show_all_win()
        looser.show_fail()
    else:
        self.bag.players.show_tie_fail()

func add_explosion(position):
    var explosion = self.explosion_template.instance()

    self.current_map.add_child(explosion)
    explosion.set_pos(position)


func bind_trackers():
    self.tracker_left.bind_tracking(self.bag.players.players[1], self.bag.players.players[0].camera)
    self.tracker_right.bind_tracking(self.bag.players.players[0], self.bag.players.players[1].camera)

func hide_trackers():
    self.tracker_left.hide()
    self.tracker_left.suppressed = true
    self.tracker_right.hide()
    self.tracker_right.suppressed = true

func show_trackers():
    self.tracker_left.show()
    self.tracker_left.suppressed = false
    self.tracker_right.show()
    self.tracker_right.suppressed = false
