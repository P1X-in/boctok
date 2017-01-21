
var root

var file_handler = preload('res://scripts/services/file_handler.gd').new()
var processing = preload('res://scripts/services/processing.gd').new()
var timers = preload('res://scripts/services/timers.gd').new()
var input = preload("res://scripts/input/input.gd").new()
var intro = preload("res://scripts/services/intro.gd").new()
var board = preload("res://scripts/services/board.gd").new()
var sound = preload("res://scripts/controllers/sound_controller.gd").new()
#var maps = preload("res://scripts/services/maps.gd").new()
var players = preload("res://scripts/services/players.gd").new()

func _init_bag(root):
    self.root = root
    self.processing._init_bag(self, root)
    self.timers._init_bag(self, root)
    self.input._init_bag(self)
    self.intro._init_bag(self, root)
    self.board._init_bag(self, root)
    self.sound._init_bag(self, root)
    #self.maps._init_bag(self)
    self.players._init_bag(self)

func reset():
    self.players.reset()
    self.board.reset()