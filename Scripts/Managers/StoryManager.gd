class_name StoryManager
extends Node

@export var allEmails:Dictionary = {}
@export var allFriends:Dictionary = {}
@export var allForums:Dictionary = {}
@export var allChatrooms:Dictionary = {}
@export var chatroomUpdates:Dictionary = {}

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

func advanceStory():
	if ( gameManager.isAllUnreads() ):
		if ( ! gameManager.completedChats.has("Minji-2-Invite") && gameManager.seenEmails.has("initialEmails") && gameManager.seenChats.has("initialChatrooms") && gameManager.seenForums.has("initialForums")):
			gameManager.seenChats.append("minjiInvite")
			gameManager.add_chat_segment(chatroomUpdates.get("minjiInvite"), "@jijubee")
		if ( ! gameManager.completedChats.has("Horror2-VanessaDeath") && gameManager.completedChats.has("Minji-2-Invite") ):
			gameManager.seenChats.append("vanessaDeath")
			gameManager.add_chat_segment(chatroomUpdates.get("vanessaDeath"), "Horror Fanatics - General")
		
