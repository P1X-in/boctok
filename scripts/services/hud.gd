extends Control

var fuel_gauge
var fuel_meter
var gravity_indicator
var gravity_meter
var movement_indicator
var movement_meter
var sun_indicator


var sun_position = Vector2(5000, 5000)

func _ready():
    self.fuel_gauge = self.get_node('huds/sensors/sensor1/arrow')
    self.fuel_meter = self.get_node('huds/sensors/sensor1/value')
    self.gravity_indicator = self.get_node('huds/sensors/sensor2/arrow')
    self.gravity_meter = self.get_node('huds/sensors/sensor2/value')
    self.movement_indicator = self.get_node('huds/sensors/sensor3/arrow')
    self.movement_meter = self.get_node('huds/sensors/sensor3/value')
    self.sun_indicator = self.get_node('huds/sun/arrow')

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