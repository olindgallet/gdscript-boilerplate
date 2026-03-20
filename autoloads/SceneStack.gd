extends Node
class_name SceneStack

signal pushed(scene: Node)
signal popped(scene: Node)
signal replaced(old_scene: Node, new_scene: Node)

var _stack: Array[Node] = []

func _top() -> Node:
	var top:Node = null;
	if _stack.size() > 0:
		top = _stack[_stack.size() - 1];
	return top;	

func push(packed: PackedScene, pause_below: bool = true) -> Node:
	var top:Node = _top()
	if top and pause_below:
		top.set_process(false)
		top.set_physics_process(false)
		top.set_process_input(false)
		top.set_process_unhandled_input(false)
	var inst:Node = packed.instantiate()
	get_parent().add_child(inst)
	_stack.append(inst)
	var _dummy:Error = emit_signal("pushed", inst);
	return inst

func pop() -> void:
	var top:Node = _top();
	if not top:
		return
	_stack.pop_back()
	top.queue_free()
	var _dummy:Error = emit_signal("popped", top);

	var new_top:Node = _top();
	if new_top:
		new_top.set_process(true)
		new_top.set_physics_process(true)
		new_top.set_process_input(true)
		new_top.set_process_unhandled_input(true)

func replace_top(packed: PackedScene) -> Node:
	var old_top:Node = _top();
	if old_top:
		old_top.queue_free()
		_stack.pop_back()
	var inst:Node = packed.instantiate()
	get_tree().root.add_child(inst)
	_stack.append(inst)
	var _dummy:Error = emit_signal("replaced", old_top, inst)
	return inst

func clear() -> void:
	while _stack.size() > 0:
		var n:Node = _stack.pop_back()
		if is_instance_valid(n):
			n.queue_free()
