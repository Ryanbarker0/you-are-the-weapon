extends Resource
class_name GameStats

@export var score: int = 0:
    set(value):
        score = value
        score_changed.emit(score)

@export var highscore: int = 0

@export var final_score: int = 0

signal score_changed(new_score)