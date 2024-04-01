extends MarginContainer

@onready var friendLoopIntro = %FriendLoopIntro
@onready var friendLoopWelcome = %FriendLoopWelcome
@onready var friendLoopCharacterBuilder = %FriendLoopCharacterBuilder

@onready var helloName = %HelloName
@onready var introTimer = %LogoTimer

#Form Stuff
@onready var fullNameForm = %FullNameForm
@onready var nameValidation = %NameValidation
@onready var handleForm = %HandleForm
@onready var handleValidation = %HandleValidation
@onready var theyCheckbox = %TheyCheckbox
@onready var avatarValidation = %AvatarValidation
@onready var avatar1 = %Avatar1
@onready var avatar2 = %Avatar2
@onready var avatar3 = %Avatar3
@onready var avatar4 = %Avatar4
@onready var avatar5 = %Avatar5

@onready var formValidator = %FormValidator

var allValidate = true

signal character_submit(fullName:String, handle:String, pronouns:String, avatar:Texture2D)

func display():
	show()
	friendLoopIntro.show()
	introTimer.start()

func _on_submit_button_pressed():
	allValidate = true
	formValidator.validate()
	if ( allValidate ):
		var actualHandle = handleForm.text
		if ( handleForm.text.substr(0, 1) != '@' ):
			actualHandle = '@' + actualHandle
		character_submit.emit(fullNameForm.text, actualHandle, theyCheckbox.button_group.get_pressed_button().name, avatar1.button_group.get_pressed_button().texture_normal)
		friendLoopCharacterBuilder.hide()
		helloName.text = "Hello, " + fullNameForm.text
		friendLoopWelcome.show()
		
func _on_form_validator_control_validated(control, passed, messages):
	if ( control.name == "FullNameForm" ):
		if ( passed ):
			nameValidation.hide()
		else:
			nameValidation.text = messages[0]
			nameValidation.show()
			allValidate = false
	if ( control.name == "HandleForm" ):
		if ( passed ):
			handleValidation.hide()
		else:
			handleValidation.text = messages[0]
			handleValidation.show()
			allValidate = false


func _on_done_button_pressed():
	hide()


func _on_logo_timer_timeout():
	friendLoopIntro.hide()
	friendLoopCharacterBuilder.show()
