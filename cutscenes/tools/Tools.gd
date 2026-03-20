class_name Tools extends Node2D

## Author: Olin Gallet
## Date: 8/13/2021
##
## Tools screen showing the giant Godot logo in purple fluorescent light.
## Waits for the animation to finish then changes to the title screen.
##
## Updated: 11/7/2023
##
## - Updated tween code for Godot 4.x
## - Removed timer

func _ready() -> void:
	var fade:Tween = create_tween();
	var target:Node = %GodotLogo;
	var _dummy:Variant;
	
	_dummy = fade.tween_property(target, 'modulate', Color(1, 1, 1, 1), 2.0).set_trans(Tween.TRANS_CUBIC);
	_dummy = fade.tween_interval(1);
	_dummy = fade.tween_property(target, 'modulate', Color(0, 0, 0, 1), 2.0).set_trans(Tween.TRANS_CUBIC);
	_dummy = fade.tween_callback(target.queue_free);
	_dummy = fade.tween_callback(on_fade_finished);
	
func on_fade_finished() -> void:
	Events.scene_complete.emit(EventSources.Event.TOOLS);
