extends Node
class_name Routes
enum Route {
	TOOLS,
	TITLE,
	TITLE_MENU
}
static func path(route: int) -> String:
	match route:
		Route.TOOLS: return "res://cutscenes/tools/Tools.tscn";
		Route.TITLE: return "res://ui/title/Title.tscn";
		Route.TITLE_MENU: return "res://ui/title-menu/TitleMenu.tscn";
		_: return "";
