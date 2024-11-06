extends PanelContainer

@onready var animation_player = $AnimationPlayer
@onready var content = $MarginContainer/VBoxContainer/Content



func _on_dropdown_button_toggled(toggled_on):
	if !animation_player.is_playing():
		if toggled_on:
			animation_player.play("dropdown")
		else:
			animation_player.play_backwards("dropdown")
			custom_minimum_size.x = content.size.x
