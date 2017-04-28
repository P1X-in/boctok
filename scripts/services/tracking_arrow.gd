extends Sprite

var tracked_ship = null
var viewed_camera = null
var box = null

var box_size
var box_size_margin = Vector2(0, 0)
const BOX_MARGIN_X = 60
const BOX_MARGIN_Y = 100

var ready = false
var suppressed = false

func bind_tracking(ship, camera):
    self.tracked_ship = ship
    self.viewed_camera = camera
    self.box = self.get_parent()

    self.ready = true

func _fixed_process(delta):
    if not self.ready or self.suppressed:
        return

    var vector = self.tracked_ship.avatar.get_global_pos() - viewed_camera.get_global_pos()

    if abs(vector.x) < self.box_size_margin.x and abs(vector.y) < self.box_size_margin.y:
        self.hide()
    else:
        self.show()

        self.face_tracked_ship(vector)
        vector = self.fit_vector_in_box(vector)

        self.set_pos(self.box_size + vector)


func face_tracked_ship(vector):
    self.set_rot(vector.angle() + 3.14)

func _ready():
    self.box_size = self.box.get_size() / 2
    self.box_size_margin = self.box_size - Vector2(self.BOX_MARGIN_X, self.BOX_MARGIN_Y)
    self.set_fixed_process(true)


func fit_vector_in_box(vector):
    var fitting_vector = Vector2(0, 0)
    var ratio

    if abs(vector.x) > self.box_size_margin.x:
        ratio = self.box_size_margin.x / abs(vector.x)
        fitting_vector = vector * ratio

        if abs(fitting_vector.y) > self.box_size_margin.y:
            ratio = self.box_size_margin.y / abs(fitting_vector.y)
            fitting_vector = fitting_vector * ratio
    else:
        ratio = self.box_size_margin.y / abs(vector.y)
        fitting_vector = vector * ratio

        if abs(fitting_vector.x) > self.box_size_margin.x:
            ratio = self.box_size_margin.x / abs(fitting_vector.x)
            fitting_vector = fitting_vector * ratio

    return fitting_vector
