extends VBoxContainer

@onready var emailIcon = %EmailIcon
@onready var from = %From
@onready var subject = %Subject

func display(email:Email):
	emailIcon.texture = email.icon
	from.text = email.fromName
	subject.text = email.subject
