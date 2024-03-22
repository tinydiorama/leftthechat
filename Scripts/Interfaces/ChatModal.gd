extends MarginContainer

@onready var chatSelection = %ChatSelection
@onready var chatStoryPlayer = %ChatStoryPlayer

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
	chatStoryPlayer.showChat(chat)

func _on_close_button_pressed():
	self.hide()
