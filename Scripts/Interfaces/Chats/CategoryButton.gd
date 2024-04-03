extends Button

@onready var avatarNode = %ChatroomAvatar
@onready var notificationIcon = %NotificationIcon
@onready var chatroomName = %ChatroomName
@onready var gameManager = get_node("/root/MainScreen/Utilities/GameManager")
	
func display(chatroom:Chatroom):
	chatroomName.text = chatroom.chatName
	avatarNode.texture = chatroom.avatar
	if ( gameManager.unreadChats.has(chatroom.chatName) ):
		notificationIcon.show()
	else:
		notificationIcon.hide()

