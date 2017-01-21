var anim
var list
var random_animation
var SEED = 0.777
var RAND_STARS = 100
var RAND_GALAXIES = 15

func _ready():
	rand_seed(self.SEED)
	self.anim = self.get_node("anim")
	self.list = self.anim.get_animation_list()
	if randi()%100 < self.RAND_STARS:
		self.random_animation = self.list[int(rand_range(1,4))]
		if randi()%100<self.RAND_GALAXIES:
			self.random_animation = self.list[int(rand_range(4,9))]
		self.anim.play(self.random_animation)
		self.anim.seek(randf()*self.anim.get_current_animation_length())