extends Node2D

onready var animation = $AnimationPlayer 
onready var lefthandspawn = $LeftHandSpawn
onready var righthandspawn = $RightHandSpawn
onready var musicplayer = $MusicPlayer


var phase = 1

const RightHand = preload("res://src/bosses/amalia/AmaliaHand.tscn")
const LeftHand = preload("res://src/bosses/amalia/AmaliaHandLeft.tscn")

const BADRightHand = preload("res://src/bosses/amalia/WorseAmaliaHand.tscn")
const BADLeftHand = preload("res://src/bosses/amalia/WorseAmaliaHandLeft.tscn")

enum {
	PHASEONE,
	PHASETWO,
	PHASETHREE,
	DEAD,
	VERYDEAD
}

var state = PHASEONE

func _ready():
	animation.play("RESET")
	musicplayer.play("RESET")
	Signals.connect("hand_was_destroyed", self, "amalia_is_hurt")

func send_a_signal():
	Signals.emit_signal("collectible_picked")

func amalia_is_hurt():
	phase += 1

func _physics_process(delta):
	match state:
		PHASEONE:
			if phase == 2:
				animation.play("painfromone")
		PHASETWO:
			if phase == 4:
				animation.play("painfromtwobetter")
		PHASETHREE:
			if phase == 6:
				state = DEAD
		DEAD:
			animation.play("deadhouse")
			musicplayer.play("AmaliaIsGone")
		VERYDEAD:
			animation.play("staydead")
			


func go_to_phase_two():
	animation.play("RESET")
	state = PHASETWO
	summon_both_hands()

func go_to_phase_three():
	animation.play("RESET")
	state = PHASETHREE
	summon_worse_hands()

func please_stay_dead():
	state = VERYDEAD
	print("please")

func summon_both_hands():
	var righthanded = RightHand.instance()
	righthanded.global_position = righthandspawn.global_position
	get_tree().get_root().add_child(righthanded)
	var lefthanded = LeftHand.instance()
	lefthanded.global_position = lefthandspawn.global_position
	get_tree().get_root().add_child(lefthanded)

func summon_worse_hands():
	var righthandedworse = BADRightHand.instance()
	righthandedworse.global_position = righthandspawn.global_position
	get_tree().get_root().add_child(righthandedworse)
	var lefthandedworse = BADLeftHand.instance()
	lefthandedworse.global_position = lefthandspawn.global_position
	get_tree().get_root().add_child(lefthandedworse)
