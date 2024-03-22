extends MarginContainer

@onready var splashScreen = %FriendSplashScreen
@onready var friendList = %FriendList
@onready var friendPanel = %FriendPanel
@onready var friendTimer = %FriendTimer

var friends:Array[Friend] = []

func openModal(allFriends):
	show()
	friends = allFriends
	friendList.hide()
	friendPanel.hide()
	splashScreen.show()
	friendTimer.start()

func _on_close_button_pressed():
	self.hide()


func _on_friend_timer_timeout():
	splashScreen.hide()
	friendTimer.stop()
	friendList.populate_friends(friends)
