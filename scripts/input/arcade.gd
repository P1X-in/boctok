extends "res://scripts/input/abstract_device.gd"

func _init():
    self.handled_input_types = [
        InputEvent.JOYSTICK_MOTION,
        InputEvent.JOYSTICK_BUTTON,
    ]

func handle_event(event):
    var handler
    for handler_id in self.event_handlers:
        handler = self.event_handlers[handler_id]
        if handler.type == event.type:
            if (handler.type == InputEvent.JOYSTICK_MOTION && handler.axis == event.axis) or (handler.type == InputEvent.JOYSTICK_BUTTON && handler.button_index == event.button_index):
                handler.handle(event)