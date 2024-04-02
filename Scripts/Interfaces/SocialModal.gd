extends MarginContainer

@onready var splashScreen = %FriendSplashScreen
@onready var friendList = %FriendList
@onready var friendPanel = %FriendPanel
@onready var friendTimer = %FriendTimer
@onready var gameManager = get_node("/root/MainScreen/Utilities/GameManager")
	

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
	gameManager.saveGame()


func _on_friend_timer_timeout():
	splashScreen.hide()
	friendTimer.stop()
	friendList.populate_friends(friends)


func _on_friend_panel_friend_back_pressed():
	friendList.populate_friends(friends)
	gameManager.saveGame()
