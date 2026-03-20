#extends Tween
#
#var options:Array;
#var option_tier:int;
#var home_x:int;
#var home_y:int;
#
#const OPTIONS_OPTION = '_1_Options';
#const SINGLE_PLAYER_OPTION = '_1_SinglePlayer';
#const MULTIPLAYER_OPTION = '_1_Multiplayer';
#
#const ARTHUB_OPTION = '_2_ArtHub';
#const CONFIGURATION_OPTION = '_2_Configuration';
#const CREDITS_OPTION = '_2_Credits';
#
#const SCORE_ATTACK_OPTION = '_2_ScoreAttack';
#const STORY_OPTION = '_2_Story';
#const TRAINING_OPTION = '_2_Training';
#
#const LOCAL_OPTION = '_2_Local';
#const ONLINE_OPTION = '_2_Online';
#
#@onready var OPTIONS_NODE = $MenuContainer/_1_Options;
#@onready var SINGLE_PLAYER_NODE = $MenuContainer/_1_SinglePlayer;
#@onready var MULTIPLAYER_NODE = $MenuContainer/_1_Multiplayer;
#
#@onready var ARTHUB_NODE = $MenuContainer/_2_ArtHub;
#@onready var CONFIGURATION_NODE = $MenuContainer/_2_Configuration;
#@onready var CREDITS_NODE = $MenuContainer/_2_Credits;
#
#@onready var SCORE_ATTACK_NODE = $MenuContainer/_2_ScoreAttack;
#@onready var STORY_NODE = $MenuContainer/_2_Story;
#@onready var TRAINING_NODE = $MenuContainer/_2_Training;
#
#@onready var LOCAL_NODE = $MenuContainer/_2_Local;
#@onready var ONLINE_NODE = $MenuContainer/_2_Online;
#
#@onready var DELAY_NODE = $MenuContainer/Delay;
#signal animation_completed;
#
###
## Author: Olin Gallet
## Date: 8/14/2021
##
## Handles fading in and fading out the menu.
#func _ready():
#	options = [OPTIONS_NODE,
#				SINGLE_PLAYER_NODE,
#				MULTIPLAYER_NODE];
#	option_tier = 1;
#	home_x = options[0].position.x;
#	home_y = options[0].position.y;
#
#	options[0].scale.x = .75;
#	options[0].scale.y = .75;
#
#	options[1].position.x = home_x - 100;
#	options[1].position.y = home_y + 180;
#
#	options[2].scale.x = .75;
#	options[2].scale.y = .75;	
#	options[2].position.x = home_x;
#	options[2].position.y = options[1].position.y + 180;
#
#	#self.interpolate_property($MenuContainer, 'modulate',
#	#	Color(1, 1, 1, 0), Color(1, 1, 1, 1), 1.0, 
#	#	Tween.TRANS_CUBIC, Tween.EASE_IN);
#	#self.start();
#	#await self.tween_completed;
#	#emit_signal('animation_completed');
#
#func _on_TitleMenu_key_pressed(key_value):
#	if key_value == 0:
#		_rotate_menu_down();
#	elif (key_value == 1 || key_value == 4) && option_tier == 1:
#		option_tier = 2;
#		if options[1].name == MULTIPLAYER_OPTION:
#			_load_menu(SCORE_ATTACK_NODE,
#			LOCAL_NODE,
#			ONLINE_NODE);
#		elif options[1].name == SINGLE_PLAYER_OPTION:
#			_load_menu(SCORE_ATTACK_NODE,
#			STORY_NODE,
#			TRAINING_NODE);
#		elif options[1].name == OPTIONS_OPTION:
#			_load_menu(ARTHUB_NODE,
#			CONFIGURATION_NODE,
#			CREDITS_NODE)
#		else:
#			emit_signal('animation_completed');
#	elif key_value == 2:
#		_rotate_menu_up();
#	elif (key_value == 3 || key_value == 5) && option_tier == 2:
#		option_tier = 1;
#		_goto_main_menu();
#
#func _rotate_menu_up():
#	## Up pressed ##
#		var option3x = options[2].position.x;
#		var option3y = options[2].position.y;
#
#		self.interpolate_property(options[0], 'modulate',
#			Color(1, 1, 1, 1), Color(1, 1, 1, 0), .1, 
#			Tween.TRANS_CUBIC, Tween.EASE_IN);
#		self.interpolate_property(options[0], 'position',
#			Vector2(home_x, home_y),
#			Vector2(options[2].position.x, options[2].position.y), .2,
#			Tween.TRANS_CUBIC, Tween.EASE_IN);	
#		self.interpolate_property(options[2], 'position',
#			Vector2(option3x, option3y),
#			Vector2(options[1].position.x, options[1].position.y), .2,
#			Tween.TRANS_CUBIC, Tween.EASE_IN);	
#		self.interpolate_property(options[1], 'position',
#			Vector2(options[1].position.x, options[1].position.y),
#			Vector2(home_x, home_y), .2,
#			Tween.TRANS_CUBIC, Tween.EASE_IN);
#		self.start();
#		await self.tween_completed;
#		self.interpolate_property(options[1], 'scale',
#			Vector2(1, 1), Vector2(.75, .75), .2,
#			Tween.TRANS_CUBIC, Tween.EASE_IN);
#		self.interpolate_property(options[2], 'scale',
#			Vector2(.75, .75), Vector2(1, 1), .2,
#			Tween.TRANS_CUBIC, Tween.EASE_IN);
#		self.interpolate_property(options[0], 'modulate',
#			Color(1, 1, 1, 0), Color(1, 1, 1, 1), .1, 
#			Tween.TRANS_CUBIC, Tween.EASE_IN);
#		self.start();
#		await self.tween_completed;
#		options.push_back(options.pop_front());
#		DELAY_NODE.start();
#		await DELAY_NODE.timeout;
#		emit_signal('animation_completed');
#
#func _rotate_menu_down():
#	## Down pressed ##
#		var option3x = options[2].position.x;
#		var option3y = options[2].position.y;
#
#		self.interpolate_property(options[2], 'modulate',
#			Color(1, 1, 1, 1), Color(1, 1, 1, 0), .1, 
#			Tween.TRANS_CUBIC, Tween.EASE_IN);
#		self.interpolate_property(options[2], 'position',
#			Vector2(options[2].position.x, options[2].position.y),
#			Vector2(home_x, home_y), .2,
#			Tween.TRANS_CUBIC, Tween.EASE_IN);	
#		self.interpolate_property(options[0], 'position',
#			Vector2(home_x, home_y),
#			Vector2(options[1].position.x, options[1].position.y), .2,
#			Tween.TRANS_CUBIC, Tween.EASE_IN);	
#		self.interpolate_property(options[1], 'position',
#			Vector2(options[1].position.x, options[1].position.y),
#			Vector2(option3x, option3y), .2,
#			Tween.TRANS_CUBIC, Tween.EASE_IN);
#		self.start();
#		await self.tween_completed;
#		self.interpolate_property(options[1], 'scale',
#			Vector2(1, 1), Vector2(.75, .75), .2,
#			Tween.TRANS_CUBIC, Tween.EASE_IN);
#		self.interpolate_property(options[0], 'scale',
#			Vector2(.75, .75), Vector2(1, 1), .2,
#			Tween.TRANS_CUBIC, Tween.EASE_IN);
#		self.interpolate_property(options[2], 'modulate',
#			Color(1, 1, 1, 0), Color(1, 1, 1, 1), .1, 
#			Tween.TRANS_CUBIC, Tween.EASE_IN);
#		self.start();
#		await self.tween_completed;
#		options.push_front(options.pop_back());
#		DELAY_NODE.start();
#		await DELAY_NODE.timeout;
#		emit_signal('animation_completed');
#
#func _goto_main_menu():
#	if options[1].name in [ARTHUB_OPTION, CONFIGURATION_OPTION, CREDITS_OPTION]:
#		_load_menu(MULTIPLAYER_NODE, OPTIONS_NODE, SINGLE_PLAYER_NODE);
#	elif options[1].name in [SCORE_ATTACK_OPTION, STORY_OPTION, TRAINING_OPTION]:
#		_load_menu(OPTIONS_NODE, SINGLE_PLAYER_NODE, MULTIPLAYER_NODE);
#	else:
#		_load_menu(SINGLE_PLAYER_NODE, MULTIPLAYER_NODE, OPTIONS_NODE);
#
#func _load_menu(option1:Node, option2:Node, option3:Node):
#	self.interpolate_property(options[0], 'modulate',
#		Color(1, 1, 1, 1), Color(1, 1, 1, 0), .2, 
#		Tween.TRANS_CUBIC, Tween.EASE_IN);
#	self.interpolate_property(options[1], 'modulate',
#		Color(1, 1, 1, 1), Color(1, 1, 1, 0), .2, 
#		Tween.TRANS_CUBIC, Tween.EASE_IN);
#	self.interpolate_property(options[2], 'modulate',
#		Color(1, 1, 1, 1), Color(1, 1, 1, 0), .2, 
#		Tween.TRANS_CUBIC, Tween.EASE_IN);
#	self.start();
#	await self.tween_completed;
#
#	options = [option1, option2, option3];
#	self.interpolate_property(options[0], 'modulate',
#		Color(1, 1, 1, 0), Color(1, 1, 1, 1), .2, 
#		Tween.TRANS_CUBIC, Tween.EASE_IN);
#	self.interpolate_property(options[1], 'modulate',
#		Color(1, 1, 1, 0), Color(1, 1, 1, 1), .2, 
#		Tween.TRANS_CUBIC, Tween.EASE_IN);
#	self.interpolate_property(options[2], 'modulate',
#		Color(1, 1, 1, 0), Color(1, 1, 1, 1), .2, 
#		Tween.TRANS_CUBIC, Tween.EASE_IN);
#
#	options[0].scale.x = .75;
#	options[0].scale.y = .75;
#	options[0].position.x = home_x;
#	options[0].position.y = home_y;
#
#	options[1].scale.x = 1;
#	options[1].scale.y = 1;
#	options[1].position.x = home_x - 100;
#	options[1].position.y = home_y + 180;
#
#	options[2].scale.x = .75;
#	options[2].scale.y = .75;	
#	options[2].position.x = home_x;
#	options[2].position.y = options[1].position.y + 180;
#
#	self.start();
#	await self.tween_completed;
#	DELAY_NODE.start();
#	await DELAY_NODE.timeout;
#	emit_signal('animation_completed');
#
