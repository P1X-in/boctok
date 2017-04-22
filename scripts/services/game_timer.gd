extends Label

var bag

const ROUND_TIME = 99

var time_left = 0

func _init_bag(bag):
    self.bag = bag

func reset():
    self.time_left = self.ROUND_TIME
    self.update_timer()

func update_timer():
    self.set_text(str(self.time_left))

func start_timer():
    self.reset()
    self.bag.timers.set_timeout(1, self, '_game_timer_tick')

func _game_timer_tick():
    if not self.bag.board.ready:
        return

    self.time_left = self.time_left - 1
    self.update_timer()

    if self.time_left < 11:
        self.bag.players.rumble_pads(0.5, 0, 0.2)

    if self.time_left == 0:
        self.bag.board.end_game(self.bag.players.get_lowest_score_player())
    else:
        self.bag.timers.set_timeout(1, self, '_game_timer_tick')
