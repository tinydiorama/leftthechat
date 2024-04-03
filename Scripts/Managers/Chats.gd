class_name Chats

var _content:Array[Chatroom] = []

func add_chatroom(chatroom:Chatroom):
	_content.append(chatroom)

func remove_chatroom(chatroom:Chatroom):
	_content.erase(chatroom)
	
func add_chat_segment(chatSegment:ChatMeta, chatroomName:String):
	for chatroom in _content:
		if ( chatroom.chatName == chatroomName ):
			chatroom.chats.append(chatSegment)
	
func get_chatrooms() -> Array[Chatroom]:
	return _content
