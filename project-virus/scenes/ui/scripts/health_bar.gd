extends Control

@export var player:Player
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var progress_bar_text: TextureProgressBar = $TextureProgressBar

var playerstats: StatsComponent
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerstats = player.get_node("StatsComponent")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_instance_valid(player):
		progress_bar.value = playerstats.health
		progress_bar_text.value = playerstats.health
	else:
		progress_bar.value = 0
		progress_bar_text.value = 0

	if progress_bar.value == 0 :
		modulate = Color(0.80, 0.20, 0.12)
		
