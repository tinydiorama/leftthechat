extends Control

@export var chatCategoryButton:PackedScene

@onready var chatCategoryList = %CategoryList
@onready var gameManager = get_node("/root/MainScreen/Utilities/GameManager")
	
var mouseOver = false
var currentChatroom:Chatroom

signal chat_selected(chat:Chatroom)

func displayChats(chats):
	for child in chatCategoryList.get_children():
		child.queue_free()
		
	for chatroom in chats:
		var chat_category = chatCategoryButton.instantiate()
		chatCategoryList.add_child(chat_category)
		chat_category.display(chatroom)
		chat_category.connect("gui_input", Callable(self, "_on_gui_input").bind([chatroom]))
		chat_category.connect("mouse_exited", Callable(self, "_on_mouse_exit"))

func _on_gui_input(event, params:Array):
	mouseOver = true
	currentChatroom = params[0]
	
func _on_mouse_exit():
	mouseOver = false

func _input(event):
	if event is InputEventMouseButton:
		if mouseOver == true:
			chat_selected.emit(currentChatroom)
			gameManager.unreadChats.erase(currentChatroom.chatName)
			mouseOver = false
