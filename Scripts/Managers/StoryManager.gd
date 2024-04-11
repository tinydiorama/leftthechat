class_name StoryManager
extends Node

@export var allEmails:Dictionary = {}
@export var allFriends:Dictionary = {}
@export var allForums:Dictionary = {}
@export var allChatrooms:Dictionary = {}
@export var chatroomUpdates:Dictionary = {}

@onready var gameManager = %GameManager
@onready var dayNotification = %DayNotification
@onready var mainGameNav = %MainGameNav

func addInitialContent():
	if not gameManager: await self.ready
	
	for friend in allFriends.get("initialFriends"):
		gameManager.add_friend(friend)
		
	for email in allEmails.get("initialEmails"):
		gameManager.add_email(email)

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
		if ( ! gameManager.completedChats.has("Mom-2") && gameManager.completedChats.has("Horror2-VanessaDeath") ):
			for chatroom in allChatrooms.get("day2DadChat"):
				gameManager.add_chat(chatroom)
			gameManager.seenChats.append("mom2")
			gameManager.seenChats.append("day2DadChat")
			gameManager.add_chat_segment(chatroomUpdates.get("mom2"), "Mom")
			
			if ( Globals.restaurantChoice == "burgers" ):
				for email in allEmails.get("burgerEmail"):
					gameManager.add_email(email)
					gameManager.seenEmails.append("burgerEmail")
			else:
				for email in allEmails.get("ramenEmail"):
					gameManager.add_email(email)
					gameManager.seenEmails.append("ramenEmail")
		
			dayNotification.display("Day Two")
		if ( ! gameManager.completedChats.has("Horror3-PostVanessaDeath") && gameManager.completedChats.has("Dad-1") && gameManager.completedChats.has("Mom-2")):
			gameManager.seenChats.append("day2PostVanessa")
			gameManager.add_chat_segment(chatroomUpdates.get("day2PostVanessa"), "Horror Fanatics - General")
			mainGameNav.unlockInternet()
