extends Control

var TEXT = load("res://Resources/Dialogue/test.dialogue")

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


func showChat(chat:Chatroom, gameManagerPassed:GameManager):
	gameManager = gameManagerPassed
	
	dialogueController.clearChat()
		
	currentChat = chat
		
	for chatMessages in chat.chats:
		currentChatMeta = chatMessages
		if ( gameManager.completedChats.has(currentChatMeta.chatMetaName) ) : # just display the messages that have been previously shown
			dialogueController.addChatNode(currentChatMeta, gameManager)
		else:
			chat_playing.emit()
			gameManager.deleteChatHistory(currentChatMeta.chatMetaName)
			#var chatScene = DialogueManager.append_dialogue_balloon_scene(POP_BALLOON, dialogue_container, chatMessages.chatPath, "start")
			dialogueController.start(chatMessages.chatPath, "start")
			if ( ! dialogueController.is_connected("chat_ended", _on_chat_ended)):
				dialogueController.connect("chat_ended", _on_chat_ended)
			if ( ! dialogueController.is_connected("chat_message_seen", _on_chat_seen)):
				dialogueController.connect("chat_message_seen", _on_chat_seen)
		#print(chatMessages.chatPath)

func _on_chat_ended():
	currentChatMeta.unlocked = true
	gameManager.completedChats.append(currentChatMeta.chatMetaName)
	gameManager.unreadChats.erase(currentChatMeta.chatroomName)
	
func _on_chat_seen(id:String):
	gameManager.addChatHistory(currentChatMeta.chatMetaName, id)
	gameManager.saveGame()

func _on_dialogue_controller_back_button():
	chat_back.emit()
