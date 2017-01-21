

var bag

var player_template = preload("res://scripts/entities/player.gd")
var players = []

func _init_bag(bag):
    self.bag = bag
    self.bind_players()

func bind_players():
    self.players = [
        self.player_template.new(self.bag, 0),
    ]

func is_gamepad_in_use(id):
    for player in self.players:
        if player.gamepad_id == id:
            return true
    return false

func is_keyboard_in_use():
    for player in self.players:
        if player.keyboard_use:
            return true
    return false

func spawn_players():
    for player in self.players:
        player.attach()

func reset():
    for player in self.players:
        player.reset()
