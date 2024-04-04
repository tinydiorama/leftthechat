extends Control

@export var chatCategoryButton:PackedScene

@onready var chatCategoryList = %CategoryList
@onready var gameManager = get_node("/root/MainScreen/Utilities/GameManager")

var currentChatroom:Chatroom

signal chat_selected(chat:Chatroom)

func displayChats(chats):
	for child in chatCategoryList.get_children():
		child.queue_free()
		
	for chatroom in chats:
		var chat_category = chatCategoryButton.instantiate()
		chatCategoryList.add_child(chat_category)
		chat_category.display(chatroom)
		chat_category.connect("pressed", Callable(self, "_onPressed").bind([chatroom]))

func _onPressed(params:Array):
	currentChatroom = params[0]
	chat_selected.emit(currentChatroom)
