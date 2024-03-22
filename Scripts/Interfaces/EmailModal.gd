extends MarginContainer

@onready var emailList = %EmailList

var emails:Array[Email] = []

func openModal(allEmails):
	show()
	emails = allEmails
	emailList.populate_emails(emails)

func _on_close_button_pressed():
	self.hide()
