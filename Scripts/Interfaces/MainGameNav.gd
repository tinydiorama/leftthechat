extends Control

# Modals
@onready var chatModal = $ChatModal
@onready var settingsModal = %SettingsModal
@onready var internetModal = %InternetModal
@onready var emailModal = %EmailModal
@onready var socialModal = %SocialModal
@onready var forumModal = %ForumModal

# Nav buttons
@onready var chatButton = %ChatroomButton
@onready var internetButton = %InternetButton
@onready var socialButton = %SocialButton
@onready var emailButton = %EmailButton
@onready var forumButton = %ForumButton

@onready var musicPlayer = $VBoxContainer/MusicPlayerContainer
@onready var mainMenu = $VBoxContainer/Menu

@onready var gameManager = %GameManager

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ( gameManager.unreadEmails.size() > 0 ):
		emailButton.get_node("NotificationIcon").show()
	else:
		emailButton.get_node("NotificationIcon").hide()
	if ( gameManager.unreadForums.size() > 0 ):
		forumButton.get_node("NotificationIcon").show()
	else:
		forumButton.get_node("NotificationIcon").hide()


func _on_menu_button_pressed():
	chatModal.openModal(gameManager.chats.get_chatrooms())


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


func _on_game_manager_new_chat():
	chatButton.get_node("NotificationIcon").show()


func _on_game_manager_new_email():
	emailButton.get_node("NotificationIcon").show()


func _on_game_manager_new_forum():
	forumButton.get_node("NotificationIcon").show()


func _on_game_manager_new_friend():
	socialButton.get_node("NotificationIcon").show()
