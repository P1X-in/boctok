var bag

var avatar
var is_processing = false
var free_avatar = true
var initial_position = Vector2(0, 0)

var sounds = {}

func _init(bag):
    self.bag = bag

func get_pos():
    return self.avatar.get_pos()

func spawn(position):
    self.attach()
    self.initial_position = position
    self.avatar.set_pos(self.initial_position)

func despawn():
    self.is_processing = false
    self.detach()
    if self.free_avatar:
        self.avatar.queue_free()

func attach():
    self.is_processing = true
    self.bag.board.attach_object(self.avatar)

func detach():
    self.is_processing = false
    self.bag.board.detach_object(self.avatar)

func calculate_distance_to_object(object):
    return self.calculate_distance(object.get_pos())

func calculate_distance(their_position):
    var my_position = self.get_pos()
    var delta_x = abs(my_position.x - their_position.x)
    var delta_y = abs(my_position.y - their_position.y)

    return sqrt(delta_x * delta_x + delta_y * delta_y)

func play_sound(name):
    if self.sounds.has(name):
        self.bag.sound.play(self.sounds[name])
