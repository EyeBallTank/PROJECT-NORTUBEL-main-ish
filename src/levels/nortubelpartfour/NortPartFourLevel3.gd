extends Node2D

onready var animation = $AnimationPlayer 
onready var lefthandspawn = $LeftHandSpawn
onready var righthandspawn = $RightHandSpawn


var phase = 1

const RightHand = preload("res://src/bosses/amalia/AmaliaHand.tscn")
const LeftHand = preload("res://src/bosses/amalia/AmaliaHandLeft.tscn")


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
				animation.play("painfromtwo")
		PHASETHREE:
			if phase == 6:
				pass
		DEAD:
			animation.play("deadhouse")
		VERYDEAD:
			animation.play("staydead")


func go_to_phase_two():
	animation.play("RESET")
	state = PHASETWO
	summon_both_hands()

func go_to_phase_three():
	animation.play("RESET")
	state = PHASETHREE

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

