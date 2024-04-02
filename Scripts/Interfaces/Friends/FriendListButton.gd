extends TextureButton

@onready var friendName = $FriendName
@onready var notificationBubble = %NotificationBubble
@onready var gameManager = get_node("/root/MainScreen/Utilities/GameManager")

func display(friend:Friend):
	texture_normal = friend.avatar
	friendName.text = friend.friendName
	if ( gameManager.updatedFriends.has(friend.friendName) ):
		notificationBubble.show()
	else:
		notificationBubble.hide()
