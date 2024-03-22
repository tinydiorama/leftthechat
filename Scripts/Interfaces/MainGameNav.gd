extends Control

@onready var chatModal = $ChatModal
@onready var settingsModal = %SettingsModal
@onready var internetModal = %InternetModal
@onready var emailModal = %EmailModal
@onready var socialModal = %SocialModal
@onready var forumModal = %ForumModal
@onready var startupScreen = $VBoxContainer/StartupScreen
@onready var musicPlayer = $VBoxContainer/MusicPlayerContainer
@onready var mainMenu = $VBoxContainer/Menu

@onready var gameManager = %GameManager

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_menu_button_pressed():
	chatModal.openModal(gameManager.chats.get_chatrooms())


func _on_timer_timeout():
	startupScreen.hide()
	musicPlayer.show()
	mainMenu.show()


func _on_settings_button_pressed():
	settingsModal.show()


func _on_internet_button_pressed():
	internetModal.show()


func _on_email_button_pressed():
	emailModal.openModal(gameManager.emails.get_emails())

func _on_social_button_pressed():
	socialModal.openModal(gameManager.friends.get_friends())


func _on_forum_button_pressed():
	forumModal.openModal(gameManager.forums.get_threads())
