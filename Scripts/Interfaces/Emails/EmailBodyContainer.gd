extends MarginContainer

@onready var emailSubject = %EmailSubject
@onready var emailIcon = %EmailIcon
@onready var emailFrom = %EmailFrom
@onready var emailDate = %EmailDate
@onready var emailBody = %EmailBody

signal close_email_body

# Called when the node enters the scene tree for the first time.
func display(email:Email):
	show()
	emailSubject.text = email.subject
	emailIcon.texture = email.icon
	emailFrom.text = "From: " + email.fromName
	emailDate.text = "Sent: " + email.date
	emailBody.text = email.body


func _on_back_button_pressed():
	close_email_body.emit()
	hide()
