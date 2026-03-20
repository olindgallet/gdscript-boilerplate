class_name DiceTable extends Node

var dice_table:Array[DiceRow] = [];
const ROW_SIZE:int = 9;
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	self.add_row_to_front();

func add_row_to_back() -> void:
	self.dice_table.push_front(DiceRow.new(ROW_SIZE));

func add_row_to_front() -> void:
	self.dice_table.push_back(DiceRow.new(ROW_SIZE));
	
func get_number_of_rows() -> int:
	return self.dice_table.size();
	
func get_die_in_front(index: int) -> int:
	var i:int = 0;
	var result:int = 0;
	while result == 0 && i <= self.dice_table.size() - 1:
		if self.dice_table[self.dice_table.size() - i - 1].get_die(index) > 0:
			result = self.dice_table[self.dice_table.size() - i - 1].get_die(index);
		i = i + 1;
	return result;

func get_die_in_front_row(index: int) -> int:
	return self.dice_table[self.dice_table.size() - 1].get_die(index);

func is_front_row_clear() -> bool:
	var isClear:bool = true;
	var i:int = 0;
	while isClear && i < ROW_SIZE:
		isClear = self.dice_table[self.dice_table.size() - 1].get_die(i) < 1;
		i = i + 1;
	return isClear;
	
func remove_front_row() -> void:
	self.dice_table.remove_at(self.dice_table.size() - 1);

func set_die_in_front_row(index: int, value: int) -> void:
	self.dice_table[self.dice_table.size() - 1].set_die(index, value);
	
func set_die_in_front(index: int, value: int) -> void:
	var i:int = 0;
	while i < self.dice_table.size():	
		if self.dice_table[self.dice_table.size() - i - 1].get_die(index) > 0:
			self.dice_table[self.dice_table.size() - i - 1].set_die(index, value);
			i = self.dice_table.size();
		i = i + 1;

func get_row(index: int) -> DiceRow:
	return self.dice_table[index];
