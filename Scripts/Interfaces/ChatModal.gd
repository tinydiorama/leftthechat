extends NinePatchRect

@onready var chatSelection = %ChatSelection
@onready var chatStoryPlayer = %ChatStoryPlayer
@onready var gameManager = %GameManager
@onready var closeButton = %ChatCloseButton
	
var chats:Array[Chatroom] = []

func openModal(allChats):
	show()
	chatSelection.show()
	chatStoryPlayer.hide()
	chats = allChats
	populateChatSelection()
	
func populateChatSelection():
	chatSelection.displayChats(chats)

func _on_chat_selected(chat):
	chatSelection.hide()
	chatStoryPlayer.show()
	chatStoryPlayer.showChat(chat, gameManager)

func _on_close_button_pressed():
	gameManager.saveGame()
	self.hide()

func _on_chat_back():
	gameManager.saveGame()
	chatSelection.show()
	chatStoryPlayer.hide()
	closeButton.disabled = false
	populateChatSelection()


func _on_chat_story_player_chat_playing():
	closeButton.disabled = true


func _on_day_notification_day_notification_display():
	_on_close_button_pressed()
