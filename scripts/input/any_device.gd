
extends "res://scripts/input/abstract_device.gd"

func _init():
    self.handled_input_types = [
        InputEvent.MOUSE_BUTTON,
        InputEvent.JOYSTICK_BUTTON,
        InputEvent.KEY,
    ]

func handle_event(event):
    var handler
    for handler_id in self.event_handlers:
        handler = self.event_handlers[handler_id]
        if handler.can_handle(event):
            handler.handle(event)