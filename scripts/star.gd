var anim
var list
var random_animation
var SEED = 0.777

func _ready():
	randomize()
	rand_seed(self.SEED)
	self.anim = self.get_node("anim")
	self.list = self.anim.get_animation_list()
	if randi()%100<75:
		self.random_animation = self.list[int(rand_range(1,4))]
		if randi()%100<15:
			self.random_animation = self.list[int(rand_range(5,9))]
		self.anim.play(self.random_animation)
		self.anim.seek(randf()*self.anim.get_current_animation_length())