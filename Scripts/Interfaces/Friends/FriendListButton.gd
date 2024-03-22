extends TextureButton

@onready var friendName = $FriendName

func display(friend:Friend):
	texture_normal = friend.avatar
	friendName.text = friend.friendName
