extends Node

var _scene_stack:SceneStack;

func _init() -> void:
	#add code to pass sfx manager to scenestack.
	self._scene_stack = SceneStack.new();
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().root.ready;
	get_tree().root.add_child(self._scene_stack);
	get_tree().root.add_child(NodeReferences.sfx_manager);
	
	Events.scene_complete.connect(_on_scene_complete);
	var next_scene:Resource = load(Routes.path(Routes.Route.TOOLS));
	var _dummy:Variant = await _scene_stack.push(next_scene);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_pushed(inst: Node) -> void:
	pass

func _on_popped(inst: Node) -> void:
	pass;

func _on_scene_complete(source: int) -> void:
	match source: 
		EventSources.Event.TOOLS:
			var next_scene:Resource = load(Routes.path(Routes.Route.TITLE));
			_scene_stack.replace_top(next_scene);	
			
		EventSources.Event.TITLE:
			var next_scene:Resource = load(Routes.path(Routes.Route.TITLE_MENU
			));
			_scene_stack.replace_top(next_scene);	
