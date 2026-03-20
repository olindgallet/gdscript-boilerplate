class_name DiceRow extends Node

# A row of dice.  May contain empty spots where dies have
# been eliminated.
#
# author: Olin Gallet
# date: 28 Feb 2020

var dice: Array[int] = [];
var rng: RandomNumberGenerator;

func _init(row_size: int) -> void:
	self.rng = RandomNumberGenerator.new();
	self.rng.randomize();
	var i:int = 0;
	while i < row_size:
		dice.append(self.rng.randi_range(1,6));
		i = i + 1;

func get_die(index: int) -> int:
	return dice[index];

func get_size() -> int:
	return dice.size();
	
func set_die(index: int, value: int) -> void:
	dice[index] = value;
