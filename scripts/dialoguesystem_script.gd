extends Node2D

const DialogueButtonPreload = preload("res://dialoguebutton_scene.tscn")

@onready var DialogueLabel: RichTextLabel = $HBoxContainer/VBoxContainer/RichTextLabel
@onready var SpeakerSprite: Sprite2D = $HBoxContainer/SpeakerParent/Sprite2D

var dialogue: Array[DE]
var current_dialogue_item: int = 0
var next_item: bool = true

var player_node: CharacterBody2D

func _ready() -> void:
    visible = false
    $HBoxContainer/VBoxContainer/button_container.visible = false

    for i in get_tree().get_nodes_in_group("player"):
        player_node = i