extends Resource
class_name GameStats

@export var score: int = 0:
    set(value):
        score = value
        score_changed.emit(score)

@export var highscore: int = 0

@export var final_score: int = 0

@export var player_level: int = 1

@export var current_xp: int = 0

@export var current_rare_npc: int = 0

signal score_changed(new_score)