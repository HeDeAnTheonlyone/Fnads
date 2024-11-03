@tool
extends Control

@onready var email_list: VBoxContainer = $Sidebar/MainScreen/EmailDisplayArea/Panel/EmailList/ScrollContainer/VBoxContainer;
@onready var email_content: MarginContainer = $Sidebar/MainScreen/EmailDisplayArea/Panel/EmailContent;
@onready var subject: Label = $Sidebar/MainScreen/EmailDisplayArea/Panel/EmailContent/VBoxContainer/Subject;
@onready var from_to: Label = $Sidebar/MainScreen/EmailDisplayArea/Panel/EmailContent/VBoxContainer/ScrollContainer/VBoxContainer/MarginContainer/HBoxContainer/FromTo;
@onready var date: Label = $Sidebar/MainScreen/EmailDisplayArea/Panel/EmailContent/VBoxContainer/ScrollContainer/VBoxContainer/MarginContainer/HBoxContainer/Date;
@onready var message: Label = $Sidebar/MainScreen/EmailDisplayArea/Panel/EmailContent/VBoxContainer/ScrollContainer/VBoxContainer/MarginContainer2/Message;
var email_button: PackedScene = preload("res://ui/email/email_button.tscn");

## The amount of emails the player has got and are visible to them.
@export var sent_emails: int = 0;
## A list of id's of emails that have already been opened
@export var read_emails: Array[int] = [];

## Stores every email that the player will get.
@export var emails: Array[EmailData] = []:
	get: return emails;
	set(value):
		for i: int in range(value.size()):
			if (value[i] != null):
				value[i].id = i;
		emails = value;



func _ready() -> void:
	populate_email_list();
	visibility_changed.connect(show_emails); #Do not connect in editor, it will cause crashes.

	show_emails(); #DEBUG


func populate_email_list() -> void:
	for email: EmailData in emails:
		var email_button_instance: EmailButton = email_button.instantiate();
		email_list.add_child(email_button_instance);

		if (read_emails.find(email.id) != -1): email.is_unread = false;
		email_button_instance.id = email.id;
		email_button_instance.text = email.subject;
		email_button_instance.open_email.connect(on_open_email);


func show_emails(tab: String = "") -> void:
	email_list.show();
	email_content.hide();

	for i in range(emails.size()):
		var email_list_button: EmailButton = email_list.get_child(i);
		if (i < sent_emails):
			if (emails[i].get(tab) if emails[i].get(tab) != null else true):
				email_list_button.visible = true;
				print(emails[i].is_unread);
				email_list_button.show_unread_info(emails[i].is_unread);
		else: email_list_button.visible = false;


#region Signal Callbacks
func on_open_email(id: int) -> void:
	email_list.hide();
	email_content.show();

	if (read_emails.find(id) == -1): read_emails.append(id);

	subject.text = emails[id].subject;
	from_to.text = "from: %s,   to: %s" % [emails[id].from, emails[id].to];
	date.text = "date: %s" % emails[id].date;
	message.text = emails[id].message;

func on_close_button_pressed(): emit_signal("request_window_close");

func on_inbox_button_pressed(): show_emails();
func on_favourite_button_pressed(): show_emails("favourite");
func on_sent_button_pressed(): show_emails("sent");
func on_spam_button_pressed(): show_emails("spam");
#enregion


#region Signals
@warning_ignore("unused_signal")
signal request_window_close();
#endregion
