var root

var helpers = preload("res://scripts/services/helpers.gd").new()
var file_handler = preload('res://scripts/services/file_handler.gd').new()
var processing = preload('res://scripts/services/processing.gd').new()
var timers = preload('res://scripts/services/timers.gd').new()
var input = preload("res://scripts/input/input.gd").new()
var intro = preload("res://scripts/services/intro.gd").new()
var board = preload("res://scripts/services/board.gd").new()
var sound = preload("res://scripts/controllers/sound_controller.gd").new()
var action = preload("res://scripts/controllers/action_controller.gd").new()
var maps = preload("res://scripts/services/maps.gd").new()
var camera = preload("res://scripts/services/camera.gd").new()
var positions = preload("res://scripts/entities/positions.gd").new()
var players = preload("res://scripts/services/players.gd").new()
var enemies = preload("res://scripts/services/enemies.gd").new()
var items = preload("res://scripts/services/items.gd").new()
var battle = preload("res://scripts/services/battle.gd").new()
var hud = preload("res://scripts/services/hud.gd").new()

func _init(root_node):
    self.root = root_node
    self.processing._init_bag(self, root_node)
    self.timers._init_bag(self, root_node)
    self.input._init_bag(self)
    self.intro._init_bag(self, root_node.mount)
    self.board._init_bag(self, root_node.mount)
    self.sound._init_bag(self, root_node)
    self.action._init_bag(self)
    self.maps._init_bag(self)
    self.camera._init_bag(self)
    self.players._init_bag(self)
    self.enemies._init_bag(self)
    self.items._init_bag(self)
    self.battle._init_bag(self)
    self.hud._init_bag(self, self.board.hud)

func reset():
    self.camera.detach()
    self.players.reset()
    self.enemies.reset()
    self.battle.reset()
    self.board.reset()
    self.items.reset()