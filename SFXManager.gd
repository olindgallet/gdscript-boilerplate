extends Node
class_name SFXManager

@export var pool_size: int = 16
@export var random_pitch_jitter: float = 0.0 # e.g., 0.05 for ±5%

var _pool: Array[AudioStreamPlayer];
var _parent: Node;

func _init() -> void:
	_pool = [];	
	
func _ready() -> void:
	for i in pool_size:
		var p := AudioStreamPlayer.new()
		p.bus = "SFX"
		add_child(p)
		_pool.append(p)
	
func _get_idle_player() -> AudioStreamPlayer:
	for p in _pool:
		if not p.playing:
			return p;
	return _pool[0];

func play_sfx(stream: AudioStream, volume_db: float = 0.0, pitch_scale: float = 1.0) -> void:
	if not stream: return
	var p := _get_idle_player();
	p.stop()
	p.stream = stream
	var jitter := 1.0 + randf_range(-random_pitch_jitter, random_pitch_jitter)
	p.pitch_scale = pitch_scale * jitter
	p.volume_db = volume_db
	p.play()
