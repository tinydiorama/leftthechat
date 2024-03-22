class_name Friends

var _content:Array[Friend] = []

func add_friend(friend:Friend):
	_content.append(friend)

func remove_friend(friend:Friend):
	_content.erase(friend)
	
func get_friends() -> Array[Friend]:
	return _content
