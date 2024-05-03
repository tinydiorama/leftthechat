extends VBoxContainer

@export var friend_list_scene:PackedScene

@onready var friendGrid = %FriendGrid
@onready var friendPanel = %FriendPanel
@onready var gameManager = get_node("/root/MainScreen/Utilities/GameManager")

var mouseOver = false
var currentFriend:Friend

signal friendSelected(friend)

func populate_friends(allFriends:Array[Friend]):
	show()
	
	for child in friendGrid.get_children():
		child.queue_free()
	
	for friend in allFriends:
		var friend_slot = friend_list_scene.instantiate()
		friendGrid.add_child(friend_slot)
		friend_slot.display(friend)
		friend_slot.connect("pressed", Callable(self, "_onPressed").bind([friend]))

func _onPressed(params:Array):
	currentFriend = params[0]	
	friendSelected.emit(currentFriend)
	gameManager.updatedFriends.erase(currentFriend.friendName)
	friendPanel.display(currentFriend)
