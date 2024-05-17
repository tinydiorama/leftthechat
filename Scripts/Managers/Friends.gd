class_name Friends

var _content:Array[Friend] = []

func add_friend(friend:Friend):
	_content.append(friend)
	
func update_status(name:String, status:String):
	for friend in _content:
		if ( friend.friendName == name ):
			friend.status = status

func remove_friend(friend:Friend):
	_content.erase(friend)
	
func clear():
	_content.clear()
	
func get_friends() -> Array[Friend]:
	return _content
