extends VBoxContainer

@export var friend_list_scene:PackedScene

@onready var friendGrid = %FriendGrid
@onready var friendPanel = %FriendPanel

var mouseOver = false
var currentFriend:Friend

func populate_friends(allFriends:Array[Friend]):
	show()
	
	for child in friendGrid.get_children():
		child.queue_free()
	
	for friend in allFriends:
		var friend_slot = friend_list_scene.instantiate()
		friendGrid.add_child(friend_slot)
		friend_slot.display(friend)
		friend_slot.connect("gui_input", Callable(self, "_on_gui_input").bind([friend]))

func _on_gui_input(event, params:Array):
	mouseOver = true
	currentFriend = params[0]
	

func _input(event):
	if event is InputEventMouseButton:
		if mouseOver == true:
			friendPanel.display(currentFriend)
			mouseOver = false
