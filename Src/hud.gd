extends Sprite2D
@onready var current_palette: Label = $HUD/CurrentPalette
@onready var increase: Button = $HUD/Increase
@onready var decrease: Button = $HUD/Decrease

##current index of palette
var palette_index : int = 0:
	set(index):
		if index >= 0 and index < 12:
			palette_index = index
			material.set_shader_parameter("selected_palette", palette_index)

	get():
		current_palette.text = str("Current Palette: %s" % palette_names[palette_index].to_pascal_case())
		return palette_index
	
##name of current palette
var palette_names : Array[String] = [
	"Black & White",
	"green",
	"purple haze",
	"purple pride",
	"marvelous pink",
	"silly putty",
	"real rasberry",
	"dizzy days",
	"troll slayer orange",
	"goldfinch yellow",
	"lepton gold",
	"slick mud",
]

func _ready() -> void:
	increase.connect("pressed", _on_increase_pressed)
	decrease.connect("pressed", _on_decrease_pressed)

func _on_increase_pressed() -> void:
	palette_index += 1


func _on_decrease_pressed() -> void:
	palette_index -= 1
