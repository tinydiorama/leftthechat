class_name Forums

var _content:Array[ForumThread] = []

func add_thread(thread:ForumThread):
	_content.append(thread)

func remove_thread(thread:ForumThread):
	_content.erase(thread)
	
func get_threads() -> Array[ForumThread]:
	return _content
