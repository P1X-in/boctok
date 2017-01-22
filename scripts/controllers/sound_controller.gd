
var bag
var stream_player = StreamPlayer.new()
var sample_player = SamplePlayer.new()

var sound_volume = 0.5
var music_volume = 1.0

var samples = [
    ['rocket_bang', preload('res://scenes/share/rocket_exploded.wav')],
    ['ship_die', preload('res://scenes/share/ship_die.wav')],
    ['rocket_launch', preload('res://scenes/share/rocket_launch.wav')],
    ['swear_en_1', preload('res://scenes/share/swears/en/1.wav')],
    ['swear_en_2', preload('res://scenes/share/swears/en/2.wav')],
    ['swear_en_3', preload('res://scenes/share/swears/en/3.wav')],
    ['swear_en_4', preload('res://scenes/share/swears/en/4.wav')],
    ['swear_en_5', preload('res://scenes/share/swears/en/5.wav')],
    ['swear_en_6', preload('res://scenes/share/swears/en/6.wav')],
    ['swear_en_7', preload('res://scenes/share/swears/en/7.wav')],
    ['swear_en_8', preload('res://scenes/share/swears/en/8.wav')],
    ['swear_ru_1', preload('res://scenes/share/swears/ru/1.wav')],
    ['swear_ru_2', preload('res://scenes/share/swears/ru/2.wav')],
    ['swear_ru_3', preload('res://scenes/share/swears/ru/3.wav')],
    ['swear_ru_4', preload('res://scenes/share/swears/ru/4.wav')],
    ['swear_ru_5', preload('res://scenes/share/swears/ru/5.wav')],
    ['swear_ru_6', preload('res://scenes/share/swears/ru/6.wav')],
    ['swear_ru_7', preload('res://scenes/share/swears/ru/7.wav')],
    ['swear_ru_8', preload('res://scenes/share/swears/ru/8.wav')],
]

var soundtracks = {}

func _init_bag(bag, mount):
    self.bag = bag

    self.sample_player.set_sample_library(SampleLibrary.new())
    self.sample_player.set_polyphony(10)

    mount.add_child(self.sample_player)

    sample_player.set_default_volume_db(self.sound_volume)
    self.load_samples()

    self.soundtracks["menu"] = mount.get_node("track_menu")
    self.soundtracks["space"] = mount.get_node("track_space")

func play(sound):
    sample_player.play(sound)

func play_soundtrack(name):
    self.stop_soundtrack()

    self.soundtracks[name].play()

func stop_soundtrack():
    #self.stream_player.stop()
    for track in self.soundtracks:
        self.soundtracks[track].stop()

func load_samples():
    for sample in self.samples:
        self.sample_player.get_sample_library().add_sample(sample[0], sample[1])

func can_play_sound():
    return !self.sample_player.is_active()