extends VBoxContainer

@export var email_list_scene:PackedScene

@onready var emailList = %EmailList
@onready var emailListContainer = %EmailListContainer
@onready var emailBodyContainer = %EmailBodyContainer

var mouseOver = false
var currentEmail:Email

func populate_emails(allEmails):
	
	for child in emailList.get_children():
		child.queue_free()
	
	for email in allEmails:
		var email_slot = email_list_scene.instantiate()
		add_child(email_slot)
		email_slot.display(email)
		email_slot.connect("gui_input", Callable(self, "_on_gui_input").bind([email]))

func _on_gui_input(event, params:Array):
	mouseOver = true
	currentEmail = params[0]
	

func _input(event):
	if event is InputEventMouseButton:
		if mouseOver == true:
			emailBodyContainer.display(currentEmail)
			mouseOver = false
