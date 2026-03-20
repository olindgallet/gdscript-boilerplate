class_name Title extends Node2D

## Author: Olin Gallet
## Date: 8/13/2021
##
## Title screen for the press start tickler.
## 
## Author: Olin Gallet
## Updated: 11/7/2023

var allowing_input:bool = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween:Tween = create_tween();
	var title:Node = %TitleText;
	var _dummy:Variant;
	var thud:Resource = load(SFXResources.path(SFXResources.SFX.TITLE_THUD));
	
	_dummy=tween.tween_property(title, 'position:y', 240.0, 2);
	_dummy=tween.tween_callback(func()->void: NodeReferences.sfx_manager.play_sfx(thud));
	_dummy=tween.tween_property(title, 'position:y', 120.0, 1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT);
	_dummy=tween.tween_property(title, 'position:y', 240.0, .75).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT);
	_dummy=tween.tween_callback(func()->void: NodeReferences.sfx_manager.play_sfx(thud));
	_dummy=tween.tween_property(title, 'position:y', 180.0, .5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT);
	_dummy=tween.tween_interval(.125);
	_dummy=tween.tween_property(title, 'position:y', 240.0, .5).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT);
	_dummy=tween.tween_callback(func()->void: NodeReferences.sfx_manager.play_sfx(thud));
	_dummy=tween.tween_interval(1);
	_dummy=tween.tween_callback(ready_to_start);

func ready_to_start() -> void:
	var tween:Tween = create_tween();
	var press_start_text:Node = %PressStartText;
	var _dummy:Variant;
	allowing_input = true;
	
	_dummy=tween.tween_property(press_start_text, 'modulate', Color(1, 1, 1, 1), 1).set_trans(Tween.TRANS_CUBIC);
	_dummy=tween.tween_property(press_start_text, 'modulate', Color(1, 1, 1, 0), 1).set_trans(Tween.TRANS_CUBIC);
	_dummy=tween.tween_interval(.1);
	_dummy=tween.set_loops();
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta:float) -> void:
	pass;
	
func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("ui_end") or 
	event.is_action_pressed("ui_accept")) and allowing_input:
		var tween:Tween = create_tween();
		var cloud_layer:Node = %CloudSprites;
		var dice_layer:Node = %DiceSprites;
		var title_text:Node = %TitleText
		var press_start_text:Node = %PressStartText
		var _dummy:Variant;
		
		_dummy=tween.parallel().tween_property(cloud_layer, 'modulate', Color(1, 1, 1, 0), 1).set_trans(Tween.TRANS_CUBIC);
		_dummy=tween.parallel().tween_property(dice_layer, 'modulate', Color(1, 1, 1, 0), 1).set_trans(Tween.TRANS_CUBIC);
		_dummy=tween.parallel().tween_property(title_text, 'modulate', Color(1, 1, 1, 0), 1).set_trans(Tween.TRANS_CUBIC);
		_dummy=tween.parallel().tween_property(press_start_text, 'modulate', Color(1, 1, 1, 0), 1).set_trans(Tween.TRANS_CUBIC);
		_dummy=tween.tween_callback(next_screen);
		
func next_screen() -> void:
	Events.scene_complete.emit(EventSources.Event.TITLE);
