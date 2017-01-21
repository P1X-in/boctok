extends Control

var SEED = 0.777
export var MAX_STARS = 100
export var POS_X_MIN = 0
export var POS_X_MAX = 1024
export var POS_Y_MIN = 0
export var POS_Y_MAX = 1024

var star_master = preload("res://scenes/space_background/star.tscn")
var star
var random_pos

func _ready():
    rand_seed(self.SEED)
    randomize()
    for i in range(0,self.MAX_STARS):
        self.star = self.star_master.instance()
        self.random_pos = Vector2(rand_range(self.POS_X_MIN,self.POS_X_MAX),rand_range(self.POS_Y_MIN,self.POS_Y_MAX))
        self.star.set_pos(self.random_pos)
        self.add_child(self.star)
