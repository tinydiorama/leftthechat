extends Control

var TEXT = load("res://Resources/Dialogue/test.dialogue")
var presentEvidenceMinji = load("res://Resources/Dialogue/Minji-PresentEvidence.dialogue")
var presentEvidenceJames = load("res://Resources/Dialogue/James-PresentEvidence.dialogue")
var presentEvidenceAmelia = load("res://Resources/Dialogue/Amelia-PresentEvidence.dialogue")
var presentEvidenceApril = load("res://Resources/Dialogue/April-PresentEvidence.dialogue")
var presentEvidenceCalvin = load("res://Resources/Dialogue/Calvin-PresentEvidence.dialogue")
var presentEvidenceNoah = load("res://Resources/Dialogue/Noah-PresentEvidence.dialogue")
var presentEvidencePaige = load("res://Resources/Dialogue/Paige-PresentEvidence.dialogue")

@onready var dialogueController = %DialogueController
@onready var dialogue_container = $PanelContainer/StoryMarginContainer/StoryVBoxContainer/StoryScrollContainer

var currentChat:Chatroom
var currentChatMeta:ChatMeta
var gameManager:GameManager

signal chat_back
signal chat_playing

# Called when the node enters the scene tree for the first time.
func _ready():
	#DialogueManager.show_example_dialogue_balloon(load("res://Resources/Dialogue/test.dialogue"), "start")
	#DialogueManager.append_dialogue_balloon_scene.call_deferred(POP_BALLOON, dialogue_container, TEXT, "start")
	pass

func playDialogueDirect(dialogueToPlay):
	dialogueController.start(dialogueToPlay, "start")
	
func showChat(chat:Chatroom, gameManagerPassed:GameManager):
	gameManager = gameManagerPassed
	
	dialogueController.clearChat()
		
	currentChat = chat
	var unread = false
		
	for chatMessages in chat.chats:
		currentChatMeta = chatMessages
		if ( gameManager.completedChats.has(currentChatMeta.chatMetaName) ) : # just display the messages that have been previously shown
			dialogueController.addChatNode(currentChatMeta, gameManager)
		else:
			unread = true
			chat_playing.emit()
			gameManager.deleteChatHistory(currentChatMeta.chatMetaName)
			#var chatScene = DialogueManager.append_dialogue_balloon_scene(POP_BALLOON, dialogue_container, chatMessages.chatPath, "start")
			dialogueController.start(chatMessages.chatPath, "start")
			if ( ! dialogueController.is_connected("chat_ended", _on_chat_ended)):
				dialogueController.connect("chat_ended", _on_chat_ended)
			if ( ! dialogueController.is_connected("chat_message_seen", _on_chat_seen)):
				dialogueController.connect("chat_message_seen", _on_chat_seen)
	if ( unread == false && chat.chatName == "Minji" ):
		currentChatMeta = null
		dialogueController.start(presentEvidenceMinji, "start")
	elif ( unread == false && chat.chatName == "James" ):
		currentChatMeta = null
		dialogueController.start(presentEvidenceJames, "start")
	elif ( unread == false && chat.chatName == "Amelia" ):
		currentChatMeta = null
		dialogueController.start(presentEvidenceAmelia, "start")
	elif ( unread == false && chat.chatName == "April" ):
		currentChatMeta = null
		dialogueController.start(presentEvidenceApril, "start")
	elif ( unread == false && chat.chatName == "Calvin" ):
		currentChatMeta = null
		dialogueController.start(presentEvidenceCalvin, "start")
	elif ( unread == false && chat.chatName == "Noah" ):
		currentChatMeta = null
		dialogueController.start(presentEvidenceNoah, "start")
	elif ( unread == false && chat.chatName == "Paige" ):
		currentChatMeta = null
		dialogueController.start(presentEvidencePaige, "start")

func _on_chat_ended():
	if ( currentChatMeta != null ):
		currentChatMeta.unlocked = true
		gameManager.completedChats.append(currentChatMeta.chatMetaName)
		gameManager.unreadChats.erase(currentChatMeta.chatroomName)
	
func _on_chat_seen(id:String):
	if ( currentChatMeta != null ):
		gameManager.addChatHistory(currentChatMeta.chatMetaName, id)
	gameManager.saveGame()

func _on_dialogue_controller_back_button():
	chat_back.emit()
