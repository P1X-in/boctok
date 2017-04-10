extends Control

var bar
var scale

func _ready():
    self.bar = self.get_node('huds/level')
    self.scale = Vector2(1, -1)

func update_fuel(amount):
    self.scale.y = float(-1 * amount) / 100.0
    print(self.scale)
    self.bar.set_scale(self.scale)
