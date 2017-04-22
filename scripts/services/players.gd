

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

    self.players[0].bind_keyboard()
    self.players[0].bind_gamepad(1)
    self.players[0].bind_camera(self.bag.board.viewport_left)
    self.players[0].bind_hud(self.bag.board.hud_left, self.bag.board.fuel_gauge_left)
    self.players[0].bind_newspaper(self.bag.board.newspaper_left)
    self.players[1].bind_gamepad(0)
    self.players[1].bind_camera(self.bag.board.viewport_right)
    self.players[1].bind_hud(self.bag.board.hud_right, self.bag.board.fuel_gauge_right)
    self.players[1].bind_newspaper(self.bag.board.newspaper_right)

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

func despawn_players():
    for player in self.players:
        player.detach()


func reset():
    for player in self.players:
        player.reset()

func show_tie_fail():
    for player in self.players:
        player.show_fail()

func show_all_win():
    for player in self.players:
        player.show_win()


func get_lowest_score_player():
    var player1 = self.players[0]
    var player2 = self.players[1]

    if player1.score > player2.score:
        return player2
    elif player2.score > player1.score:
        return player1
    else:
        return null

func rumble_pads(low_magnitude, high_magnitude, time):
    for player in players:
        Input.start_joy_vibration(player.gamepad_id, low_magnitude, high_magnitude, time)
