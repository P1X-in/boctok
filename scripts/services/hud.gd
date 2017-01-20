extends "res://scripts/services/abstract_screen.gd"

var time_label

var player_1_panel
var player_2_panel
var arrow
var loose

func _init_bag(bag, container):
    ._init_bag(bag, container)
    self.screen_scene = self.bag.board.screen_scene.get_node('hud')
    self.time_label = self.screen_scene.get_node('time/time_string')
    self.player_1_panel = self.screen_scene.get_node('p1')
    self.player_2_panel = self.screen_scene.get_node('p2')
    self.arrow = self.screen_scene.get_node('arrow')
    self.loose = self.screen_scene.get_node('lose')

func set_timer(time_left):
    self.time_label.set_text(str(time_left))

func update_timer():
    self.set_timer(self.bag.board.time_left)

func update_player_hp(player_id, hp):
    var panel
    if player_id == 0:
        panel = self.player_1_panel
    else:
        panel = self.player_2_panel

    var bottle1 = panel.get_node('hearth')
    var bottle2 = panel.get_node('hearth1')

    if hp > 5:
        bottle1.set_frame(10 - hp)
        bottle2.set_frame(0)
    else:
        bottle1.set_frame(4)
        bottle2.set_frame(min(5 - hp, 4))

func show_arrow():
    self.arrow.show()

func hide_arrow():
    self.arrow.hide()

func show_loose():
    self.loose.show()

func hide_loose():
    self.loose.hide()
