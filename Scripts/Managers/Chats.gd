class_name Chats

var _content:Array[Chatroom] = []

func add_chatroom(chatroom:Chatroom):
	_content.append(chatroom)

func remove_chatroom(chatroom:Chatroom):
	_content.erase(chatroom)
	
#todo set chatroom to unlocked
#todo set chat inside of chatroom to unlocked
	
func get_chatrooms() -> Array[Chatroom]:
	return _content
