extends Node
class_name SFXResources
enum SFX {
	TITLE_THUD
}
static func path(route: int) -> String:
	match route:
		SFX.TITLE_THUD: return "res://ui/title/thud.wav";
		_: return "";
