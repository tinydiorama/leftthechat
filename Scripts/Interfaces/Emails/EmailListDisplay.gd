extends VBoxContainer

@onready var emailIcon = %EmailIcon
@onready var from = %From
@onready var subject = %Subject
@onready var notificationBubble = %NotificationBubble
@onready var gameManager = get_node("/root/MainScreen/Utilities/GameManager")

func display(email:Email):
	emailIcon.texture = email.icon
	from.text = email.fromName
	subject.text = email.subject
	if ( gameManager.unreadEmails.has(email.subject) ):
		notificationBubble.show()
	else:
		notificationBubble.hide()
