extends Panel

@onready var friendName = %Name
@onready var friendHandle = %Handle
@onready var friendAge = %Age
@onready var relationshipStatus = %RelationshipStatus
@onready var status = %Status

# Called when the node enters the scene tree for the first time.
func display(friend:Friend):
	show()
	friendName.text = friend.friendName
	friendHandle.text = friend.handle
	friendAge.text = "Age: " + friend.age
	relationshipStatus.text = friend.relationship
	status.text = friend.status


func _on_back_button_pressed():
	hide()
