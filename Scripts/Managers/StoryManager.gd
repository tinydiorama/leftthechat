class_name StoryManager
extends Node

@export var allEmails:Dictionary = {}
@export var allFriends:Dictionary = {}
@export var allForums:Dictionary = {}
@export var allChatrooms:Dictionary = {}

@onready var gameManager = %GameManager

func addInitialContent():
	if not gameManager: await self.ready
	
	for friend in allFriends.get("initialFriends"):
		gameManager.add_friend(friend)
		
	for email in allEmails.get("initialEmails"):
		gameManager.add_email(email)
		
	for thread in allForums.get("initialForums"):
		gameManager.add_forum(thread)

	for chatroom in allChatrooms.get("initialChatrooms"):
		gameManager.add_chat(chatroom)
