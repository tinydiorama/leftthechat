class_name Emails

var _content:Array[Email] = []

func add_email(email:Email):
	_content.push_front(email)

func remove_email(email:Email):
	_content.erase(email)
	
func get_emails() -> Array[Email]:
	return _content
