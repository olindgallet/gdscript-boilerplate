class_name DiceCache extends Node


# A cache of dice.  Used to perform quick clears using
# set combinations.
#
# author: Olin Gallet
# date: 7 Feb 2020

var cache:Array[int];
var size: int;
const MAX_SIZE:int = 5;

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	cache = [];
	size = 0;

func add_die(die: int) -> void:
	if self.size < MAX_SIZE:
		self.cache.append(die);
		self.size = self.size + 1;
	else:
		self.cache.pop_front();
		self.cache.append(die);
		
func get_size() -> int:
	return self.size;

func get_die(index: int) -> int:
	return self.cache[index];

func clear_cache() -> void:
	self.cache = [];
	
func get_rows_cleared() -> int:
	
	return 1;
