class_name EmailData extends Resource

@export var id: int = -1;

## Also show up in favourite tab
@export var favourite: bool = false;
## Also show up in sent tab
@export var sent: bool = false;
## Also show up in spam tab
@export var spam: bool = false;

@export var subject: String = "";
@export var from: String = "";
@export var to: String = "";
@export var date: String = "";
@export_multiline var message: String = "";
