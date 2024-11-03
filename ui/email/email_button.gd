class_name EmailButton extends PanelContainer

@onready var title: Label = $MarginContainer/HBoxContainer/Title;
@onready var info: Label = $MarginContainer/HBoxContainer/Info;

var text: String:
	get: return title.text;
	set(value): title.text = value;

var id: int = -1;



func show_unread_info(is_unread: bool) -> void: info.visible = is_unread;


#region Signal Callback
func on_button_pressed() -> void: emit_signal("open_email", id);
#endregion

#region Signal
@warning_ignore("unused_signal")
signal open_email(email_id: int);
#endregion
