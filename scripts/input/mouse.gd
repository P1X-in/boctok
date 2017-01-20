
extends "res://scripts/input/abstract_device.gd"

func _init():
    self.handled_input_types = [
        InputEvent.MOUSE_MOTION,
        InputEvent.MOUSE_BUTTON,
    ]

func handle_event(event):
    var handler
    for handler_id in self.event_handlers:
        handler = self.event_handlers[handler_id]
        if handler.type == event.type:
            if handler.type == InputEvent.MOUSE_BUTTON && handler.button_index == event.button_index:
                handler.handle(event)
            elif handler.type == InputEvent.MOUSE_MOTION:
                handler.handle(event)