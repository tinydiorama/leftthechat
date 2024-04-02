extends MarginContainer

@onready var emailList = %EmailList
@onready var emailBodyContainer = %EmailBodyContainer
@onready var gameManager = get_node("/root/MainScreen/Utilities/GameManager")
	

var emails:Array[Email] = []

func openModal(allEmails):
	show()
	emails = allEmails
	emailList.populate_emails(emails)
	emailBodyContainer.hide()

func _on_close_button_pressed():
	self.hide()
	gameManager.saveGame()


func _on_email_body_container_close_email_body():
	emailList.populate_emails(emails)
	gameManager.saveGame()
