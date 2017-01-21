
var bag
var stream_player = StreamPlayer.new()
var sample_player = SamplePlayer.new()

var sound_volume = 0.5
var music_volume = 1.0

var samples = []

var soundtracks = {}

func _init_bag(bag, mount):
    self.bag = bag

    self.sample_player.set_sample_library(SampleLibrary.new())
    self.sample_player.set_polyphony(10)

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
