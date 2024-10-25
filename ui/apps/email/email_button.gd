class_name EmailButton extends Button

var id: int = -1;

func on_button_pressed() -> void: emit_signal("open_email", id);

@warning_ignore("unused_signal")
signal open_email(email_id: int);