extends Node2D

var options:Array;
var option_tier:int;
var home_x:int;
var home_y:int;
#
const OPTIONS_OPTION:String = '_1_Options';
const SINGLE_PLAYER_OPTION:String = '_1_SinglePlayer';
const MULTIPLAYER_OPTION:String = '_1_Multiplayer';
#
const ARTHUB_OPTION:String = '_2_ArtHub';
const CONFIGURATION_OPTION:String = '_2_Configuration';
const CREDITS_OPTION:String = '_2_Credits';

const SCORE_ATTACK_OPTION:String = '_2_ScoreAttack';
const STORY_OPTION:String = '_2_Story';
const TRAINING_OPTION:String = '_2_Training';

const LOCAL_OPTION:String = '_2_Local';
const ONLINE_OPTION:String = '_2_Online';

@onready var OPTIONS_NODE:Node = $MenuContainer/_1_Options;
@onready var SINGLE_PLAYER_NODE:Node = $MenuContainer/_1_SinglePlayer;
@onready var MULTIPLAYER_NODE:Node = $MenuContainer/_1_Multiplayer;

@onready var ARTHUB_NODE:Node = $MenuContainer/_2_ArtHub;
@onready var CONFIGURATION_NODE:Node = $MenuContainer/_2_Configuration;
@onready var CREDITS_NODE:Node = $MenuContainer/_2_Credits;

@onready var SCORE_ATTACK_NODE:Node = $MenuContainer/_2_ScoreAttack;
@onready var STORY_NODE:Node = $MenuContainer/_2_Story;
@onready var TRAINING_NODE:Node = $MenuContainer/_2_Training;

@onready var LOCAL_NODE:Node = $MenuContainer/_2_Local;
@onready var ONLINE_NODE:Node = $MenuContainer/_2_Online;

###
## Author: Olin Gallet
## Date: 8/14/2021
##
## Handles fading in and fading out the menu.
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	options = [OPTIONS_NODE,
				SINGLE_PLAYER_NODE,
				MULTIPLAYER_NODE];
	option_tier = 1;
	home_x = options[0].position.x;
	home_y = options[0].position.y;

	options[0].scale.x = .75;
	options[0].scale.y = .75;

	options[1].position.x = home_x - 100;
	options[1].position.y = home_y + 180;

	options[2].scale.x = .75;
	options[2].scale.y = .75;	
	options[2].position.x = home_x;
	options[2].position.y = options[1].position.y + 180;

	#Blacken out unavailable options.
	OPTIONS_NODE.self_modulate = Color(0.5,0.5,0.5,1.0);
	MULTIPLAYER_NODE.self_modulate = Color(0.5,0.5,0.5,1.0);
	ARTHUB_NODE.self_modulate = Color(0.5,0.5,0.5,1.0);
	SCORE_ATTACK_NODE.self_modulate = Color(0.5,0.5,0.5,1.0);
	STORY_NODE.self_modulate = Color(0.5,0.5,0.5,1.0);
	LOCAL_NODE.self_modulate = Color(0.5,0.5,0.5,1.0);
	ONLINE_NODE.self_modulate = Color(0.5,0.5,0.5,1.0);
	CONFIGURATION_NODE.self_modulate = Color(0.5,0.5,0.5,1.0);
	CREDITS_NODE.self_modulate = Color(0.5,0.5,0.5,1.0);
	
func _input(event:InputEvent) -> void:
	var _dummy:Variant;
	if event.is_pressed() and not event.is_echo():
		if event.is_action_pressed('ui_up'):
			set_process_input(false);
			set_block_signals(true);
			_rotate_menu_up();
			_dummy=emit_signal('key_pressed', 0);
		elif event.is_action_pressed('ui_right'):
			if options[1].name == MULTIPLAYER_OPTION:
				set_process_input(false);
				set_block_signals(true);
				option_tier = 2;
				_load_menu(SCORE_ATTACK_NODE,LOCAL_NODE,ONLINE_NODE);
			elif options[1].name == SINGLE_PLAYER_OPTION:
				set_process_input(false);
				set_block_signals(true);
				option_tier = 2;
				_load_menu(SCORE_ATTACK_NODE,STORY_NODE,TRAINING_NODE);
			elif options[1].name == OPTIONS_OPTION:
				set_process_input(false);
				set_block_signals(true);
				option_tier = 2;
				_load_menu(ARTHUB_NODE,CONFIGURATION_NODE,CREDITS_NODE);
		elif event.is_action_pressed('ui_down'):
			set_process_input(false);
			set_block_signals(true);
			_rotate_menu_down();
		elif event.is_action_pressed('ui_left'):
			if option_tier == 2:
				set_block_signals(false);
				set_process_input(true);	
				_goto_main_menu();
		elif event.is_action_pressed('ui_accept'):
			set_process_input(false);
			_dummy=emit_signal('key_pressed', 4);
		elif event.is_action_pressed('ui_cancel'):
			set_process_input(false);
			_dummy=emit_signal('key_pressed', 5);
#	else: if event.is_action_pressed("ui_accept"):
#		var singleplayer6_resource = load("res://src/screens/SinglePlayer.tscn");
#		var singleplayerscreen          = singleplayer_resource.instance();
#		get_tree().get_root().add_child(singleplayerscreen);
#		get_tree().get_root().remove_child(self);

func _rotate_menu_up() -> void:
	## Down pressed ##
	var _dummy:Variant;
	var tween:Tween = create_tween();
	var option3x:int = options[2].position.x;
	var option3y:int = options[2].position.y;
	_dummy=tween.parallel().tween_property(options[2], 'modulate', Color(1, 1, 1, 0), .1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN);
	_dummy=tween.parallel().tween_property(options[2], 'position', Vector2(home_x, home_y), .2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN);
	_dummy=tween.parallel().tween_property(options[0], 'position', Vector2(options[1].position.x, options[1].position.y), .2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN);
	_dummy=tween.parallel().tween_property(options[1], 'position', Vector2(option3x, option3y), .2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN);
	_dummy=tween.parallel().tween_property(options[1], 'scale', Vector2(.75, .75), .2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN);
	_dummy=tween.parallel().tween_property(options[0], 'scale', Vector2(1, 1), .2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN);
	_dummy=tween.tween_property(options[2], 'modulate', Color(1,1,1,1), .1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN);
	_dummy=tween.tween_callback( func()->void: $SelectSFX.play());
	_dummy=tween.tween_callback( func()->void: set_process_input(true); options.push_front(options.pop_back()) );

func _rotate_menu_down() -> void:
#	## Up pressed ##
	var _dummy:Variant;
	var tween:Tween = create_tween();
	var option3x:int = options[2].position.x;
	var option3y:int = options[2].position.y;

	_dummy=tween.parallel().tween_property(options[0], 'modulate', Color(1, 1, 1, 0), .1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN);
	_dummy=tween.parallel().tween_property(options[1], 'position', Vector2(home_x, home_y), .2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN);
	_dummy=tween.parallel().tween_property(options[2], 'position', Vector2(options[1].position.x, options[1].position.y), .2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN);
	_dummy=tween.parallel().tween_property(options[0], 'position', Vector2(option3x, option3y), .2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN);
	_dummy=tween.parallel().tween_property(options[2], 'scale', Vector2(1, 1), .2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN);
	_dummy=tween.parallel().tween_property(options[1], 'scale', Vector2(.75, .75), .2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN);
	_dummy=tween.tween_property(options[0], 'modulate', Color(1,1,1,1), .1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN);
	_dummy=tween.tween_callback(func()->void: $SelectSFX.play());
	_dummy=tween.tween_callback( func()->void: set_process_input(true); options.push_back(options.pop_front()) );

func _load_menu(option1:Node, option2:Node, option3:Node) -> void:
	var tween:Tween = create_tween();
	var _dummy:Variant;
	_dummy=tween.parallel().tween_property(options[0], 'modulate', Color(1, 1, 1, 0), .5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN);
	_dummy=tween.parallel().tween_property(options[1], 'modulate', Color(1, 1, 1, 0), .5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN);
	_dummy=tween.parallel().tween_property(options[2], 'modulate', Color(1, 1, 1, 0), .5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN);
	
	options = [option1, option2, option3];
	
	options[0].scale.x = .75;
	options[0].scale.y = .75;
	options[0].position.x = home_x;
	options[0].position.y = home_y;

	options[1].scale.x = 1;
	options[1].scale.y = 1;
	options[1].position.x = home_x - 100;
	options[1].position.y = home_y + 180;

	options[2].scale.x = .75;
	options[2].scale.y = .75;	
	options[2].position.x = home_x;
	options[2].position.y = options[1].position.y + 180;
	
	_dummy=tween.parallel().tween_property(options[0], 'modulate', Color(1, 1, 1, 1), .5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN);
	_dummy=tween.parallel().tween_property(options[1], 'modulate', Color(1, 1, 1, 1), .5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN);
	_dummy=tween.parallel().tween_property(options[2], 'modulate', Color(1, 1, 1, 1), .5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN);
	_dummy=tween.tween_callback( func()->void: set_process_input(true); set_block_signals(false) );	

func _goto_main_menu() -> void:
	if options[1].name in [ARTHUB_OPTION, CONFIGURATION_OPTION, CREDITS_OPTION]:
		_load_menu(MULTIPLAYER_NODE, OPTIONS_NODE, SINGLE_PLAYER_NODE);
	elif options[1].name in [SCORE_ATTACK_OPTION, STORY_OPTION, TRAINING_OPTION]:
		_load_menu(OPTIONS_NODE, SINGLE_PLAYER_NODE, MULTIPLAYER_NODE);
	elif options[1].name in [LOCAL_OPTION, SCORE_ATTACK_OPTION, ONLINE_OPTION]:
		_load_menu(SINGLE_PLAYER_NODE, MULTIPLAYER_NODE, OPTIONS_NODE);	
