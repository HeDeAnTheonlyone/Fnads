extends CanvasLayer


var selected_cam: int = 0;
var time_in_cams: Array[float] = [];

@onready var cam_map := $CamMap as TextureRect;


func _ready() -> void:
	for child in cam_map.get_children():
		var cam_button = child as CamButton;
		if cam_button == null: continue;
		cam_button.connect("cam_selected", change_cam);
		time_in_cams.append(0.0);


func _process(delta):
	if self.visible:
		time_in_cams[selected_cam] += delta;


func change_cam(cam_id: int) -> void:
	(cam_map.get_child(selected_cam) as CamButton).disabled = false;
	selected_cam = cam_id;