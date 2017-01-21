

var bag

var player_template = preload("res://scripts/entities/player.gd")
var players = []

func _init_bag(bag):
    self.bag = bag
    self.bind_players()

func bind_players():
    self.players = [
        self.player_template.new(self.bag, 0),
        self.player_template.new(self.bag, 1),
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
    self.players[0].spawn(Vector2(4000, 5000))
    self.players[1].spawn(Vector2(6000, 5000))

    self.players[0].bind_keyboard()
    self.players[0].bind_camera(self.bag.board.viewport_left)
    self.players[1].bind_gamepad(0)
    self.players[1].bind_camera(self.bag.board.viewport_right)

func reset():
    for player in self.players:
        player.reset()
