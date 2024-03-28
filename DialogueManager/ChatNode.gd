extends Control

@onready var balloon: Control = self
@onready var character_label: RichTextLabel = %CharacterLabel
@onready var dialogue_label: DialogueLabel = %DialogueLabel
@onready var avatar = %Avatar

@export var characterPortraits:Dictionary = {}

## The action to use for advancing the dialogue
const NEXT_ACTION = &"ui_accept"

## The action to use to skip typing the dialogue
const SKIP_ACTION = &"ui_cancel"

signal dialogueTyped

func ready():
	balloon.focus_mode = Control.FOCUS_ALL
	balloon.grab_focus()
	
func populate(dialogue_line):
	
	character_label.visible = not dialogue_line.character.is_empty()
	character_label.text = tr(dialogue_line.character, "dialogue")
	var portrait_path = characterPortraits.get(dialogue_line.character.to_lower())
	
	if portrait_path != null:
		avatar.texture = portrait_path

	dialogue_label.hide()
	dialogue_label.dialogue_line = dialogue_line
	
	dialogueTyped.emit()
	
	dialogue_label.show()
	if not dialogue_line.text.is_empty():
		dialogue_label.type_out()
		await dialogue_label.finished_typing

func showResponse(response):
	print(response)
	character_label.visible = true
	character_label.text = tr("Player", "dialogue")
	var portrait_path = null
	
	if portrait_path != null:
		avatar.texture = portrait_path
		
	dialogue_label.hide()
	dialogue_label.text = response.text
	dialogue_label.show()

func showResponseFromRawText(dialogueText:String):
	character_label.visible = true
	character_label.text = tr("Player", "dialogue")
	var portrait_path = null
	
	if portrait_path != null:
		avatar.texture = portrait_path
		
	dialogue_label.hide()
	dialogue_label.text = dialogueText
	dialogue_label.show()
