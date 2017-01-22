extends Control

var fuel_gauge
var fuel_meter
var gravity_indicator
var gravity_meter
var movement_indicator
var movement_meter
var sun_indicator
var proximity_indicators
var score

var sun_position = Vector2(5000, 5000)
const SUN_PROXIMITY_ALERT_DISTANCE = 400
const TOO_FAR = 1500

func _ready():
    self.fuel_gauge = self.get_node('huds/sensors/sensor1/arrow')
    self.fuel_meter = self.get_node('huds/sensors/sensor1/value')
    self.gravity_indicator = self.get_node('huds/sensors/sensor2/arrow')
    self.gravity_meter = self.get_node('huds/sensors/sensor2/value')
    self.movement_indicator = self.get_node('huds/sensors/sensor3/arrow')
    self.movement_meter = self.get_node('huds/sensors/sensor3/value')
    self.sun_indicator = self.get_node('huds/sun/arrow')
    self.proximity_indicators = [
        self.get_node('huds/proximity/achtung_ru'),
        self.get_node('huds/proximity/achtung_en')
    ]
    self.score = self.get_node('huds/sensors_small/sensor_small2/value')

func update_sun_indicator(ship_position):
    var difference = self.sun_position - ship_position

    self.sun_indicator.set_rot(difference.angle() + 3.14)

func update_fuel(amount):
    self.fuel_meter.set_text(str(int(amount)))

    self.fuel_gauge.set_rot(9 - ((amount/100) * 5))


func update_gravity(gravity_vector):
    if gravity_vector == Vector2(0, 0):
        self.gravity_indicator.hide()
        self.gravity_meter.set_text('---')
    else:
        self.gravity_indicator.show()
        gravity_vector = gravity_vector * 100
        self.gravity_meter.set_text(str(int(gravity_vector.length())))
        self.gravity_indicator.set_rot(gravity_vector.angle() + 3.14)


func update_ship_velocity(velocity_vector):
    if velocity_vector == Vector2(0, 0):
        self.movement_indicator.hide()
        self.movement_meter.set_text('---')
    else:
        self.movement_indicator.show()
        self.movement_meter.set_text(str(int(velocity_vector.length())))
        self.movement_indicator.set_rot(velocity_vector.angle() + 3.14)

func update_sun_warning(player):
    var distance = player.avatar.get_pos().distance_to(self.sun_position)
    if distance <= self.SUN_PROXIMITY_ALERT_DISTANCE or distance >= self.TOO_FAR:
        self.proximity_indicators[player.player_id].show()
        return true
    else:
        self.proximity_indicators[0].hide()
        self.proximity_indicators[1].hide()
        return false

func update_score(score):
    self.score.set_text(str(score))
