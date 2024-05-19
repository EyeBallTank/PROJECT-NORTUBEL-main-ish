extends KinematicBody2D

#ART PLANS:

#What about Nortubel enemies?
#NORT: OUR MAIN CHARACTERS, THEIR PARENTS
#ART: FOR OBJECTS/ITEMS BUT ONLY IF ALL ARE FINISHED
#INTERACTION IDEAS:
#CLARITY WITH BOTH LEON AND IVAN IN LOVE WITH HER
#BOOKER VS ODIN
#MATYSHA AND MCSHERRY
#RICOTTO AND KALUB
#NAMYLEA AND ZARINA
#BONKY AND PEBBLE
#UULGA AND MAIKOUTO
#YIEGOUR AND MARCUS


onready var dialoguebox = $CanvasLayer
export var boardname = "nortubel world map"
onready var sprite = $CanvasLayer/AnimatedSprite
onready var basicmessage = $Basicmessage

onready var yellowbooksprite = $MainSprite
export var yellowbookname = "artbookmain"

var test = false

func _ready():
	sprite.animation = boardname
	dialoguebox.visible = false
	basicmessage.visible = false
	yellowbooksprite.animation = yellowbookname

func _physics_process(delta):
	if test == true:
		if Input.is_action_just_pressed("standstill") and dialoguebox.visible == false:
			dialoguebox.visible = true
	elif test == false:
		dialoguebox.visible = false
	if Input.is_action_just_pressed("runaway"):
		test = false



func _on_TalktoArea_body_entered(body):
	if body.name == "Player":
		basicmessage.visible = true
		test = true

func _on_TalktoArea_body_exited(body):
	if body.name == "Player":
		basicmessage.visible = false
		test = false
