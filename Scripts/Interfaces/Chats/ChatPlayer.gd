extends Control

var POP_BALLOON = load("res://DialogueManager/DialogueController.tscn")
@onready var dialogue_container = $PanelContainer/StoryMarginContainer/StoryVBoxContainer/StoryScrollContainer
var TEXT = load("res://Resources/Dialogue/test.dialogue")



# Called when the node enters the scene tree for the first time.
func _ready():
	#DialogueManager.show_example_dialogue_balloon(load("res://Resources/Dialogue/test.dialogue"), "start")
	#DialogueManager.append_dialogue_balloon_scene.call_deferred(POP_BALLOON, dialogue_container, TEXT, "start")
	pass


func showChat(chat:Chatroom):
	for chatMessages in chat.chats:
		if ( chatMessages.unlocked ) : # just display the messages that have been previously shown
			pass
		else:
			DialogueManager.append_dialogue_balloon_scene.call_deferred(POP_BALLOON, dialogue_container, chatMessages.chatPath, "start")
		#print(chatMessages.chatPath)
