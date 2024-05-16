class_name StoryManager
extends Node

@export var initialChatsTable:Dictionary
@export var allEmails:Dictionary = {}
@export var allFriends:Dictionary = {}
@export var allForums:Dictionary = {}
@export var allChatrooms:Dictionary = {}
@export var chatroomUpdates:Dictionary = {}
@export var allEvidence:Dictionary = {}

@export var evidencePlan:Dictionary = {}

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
		if ( chatroom.chatName == "Minji" || chatroom.chatName == "Horror Fanatics - General" || chatroom.chatName == "Mom"):
			gameManager.add_chat(chatroom)
		else:
			gameManager.chats.add_chatroom(chatroom)
		
	gameManager.add_evidence(allEvidence.get("schoolid"))
	gameManager.obtainedEvidence.append("schoolid")
	
	for chatKey in initialChatsTable:
		var chatHistory = initialChatsTable[chatKey]
		gameManager.completedChats.append(chatKey)
		for chatId in chatHistory:
			gameManager.addChatHistory(chatKey, chatId)
			
	gameManager.saveGame()

func advanceStory():
	if ( gameManager.isAllUnreads() ):
		if ( ! gameManager.completedChats.has("Minji-2-Invite") && gameManager.seenEmails.has("initialEmails") && gameManager.seenChats.has("initialChatrooms") && gameManager.seenForums.has("initialForums")):
			gameManager.seenChats.append("minjiInvite")
			gameManager.add_chat_segment(chatroomUpdates.get("minjiInvite"), "Minji")
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
		
			gameManager.dayIndicator = "day2"
			dayNotification.display("Day Two")
		if ( ! gameManager.completedChats.has("Horror3-PostVanessaDeath") && gameManager.completedChats.has("Dad-1") && gameManager.completedChats.has("Mom-2")):
			gameManager.seenChats.append("day2PostVanessa")
			gameManager.add_chat_segment(chatroomUpdates.get("day2PostVanessa"), "Horror Fanatics - General")
		if ( ! gameManager.internetUnlocked && gameManager.completedChats.has("Horror3-PostVanessaDeath")):
			mainGameNav.unlockInternet()
		if ( ! gameManager.completedChats.has("Horror4-PostVanessaObit") && gameManager.vanessaArticleRead ):
			gameManager.seenChats.append("day2PostObit")
			gameManager.add_chat_segment(chatroomUpdates.get("day2PostObit"), "Horror Fanatics - General")
		if ( ! gameManager.completedChats.has("Minji3-Worried") && gameManager.completedChats.has("Horror4-PostVanessaObit")):
			gameManager.seenChats.append("minjiWorried")
			gameManager.add_chat_segment(chatroomUpdates.get("minjiWorried"), "Minji")
		if ( ! gameManager.completedChats.has("Horror5-Aftermath") && gameManager.completedChats.has("Minji3-Worried")):
			gameManager.seenChats.append("horror5Aftermath")
			gameManager.add_chat_segment(chatroomUpdates.get("horror5Aftermath"), "Horror Fanatics - General")
			gameManager.seenChats.append("minjiVanessaEmail")
			gameManager.add_chat_segment(chatroomUpdates.get("minjiVanessaEmail"), "Minji")
			gameManager.seenChats.append("aprilInitialDMs")
			gameManager.add_chat_segment(chatroomUpdates.get("aprilInitialDMs"), "April")
			
			gameManager.dayIndicator = "day3"
			dayNotification.display("Day Three")
	if ( gameManager.completedChats.has("Minji4-VanessaEmail") && ! gameManager.seenEmails.has("minjiVanessaEmail")):
		for email in allEmails.get("minjiVanessaEmail"):
			gameManager.add_email(email)
			gameManager.seenEmails.append("minjiVanessaEmail")
	if ( ! gameManager.seenChats.has("paigeInitialDMs") && gameManager.completedChats.has("Horror5-Aftermath") ):
			gameManager.seenChats.append("paigeInitialDMs")
			gameManager.add_chat_segment(chatroomUpdates.get("paigeInitialDMs"), "Paige")
	if ( ! gameManager.seenChats.has("minji5Trust") && gameManager.unreadEmails.size() == 0 && gameManager.seenEmails.has("minjiVanessaEmail")):
		gameManager.seenChats.append("minji5Trust")
		gameManager.add_chat_segment(chatroomUpdates.get("minji5Trust"), "Minji")
	if ( gameManager.isAllUnreads()): 
		if ( ! gameManager.completedChats.has("Horror6-NoOneCameForward") && gameManager.completedChats.has("Paige1-Suspicious")):
			gameManager.add_chat_segment(chatroomUpdates.get("horrorNoOneCameForward"), "Horror Fanatics - General")
			gameManager.seenChats.append("horrorNoOneCameForward")
		if ( ! gameManager.completedChats.has("NoahMinji-VanessaEmails") && gameManager.completedChats.has("Horror6-NoOneCameForward")):
			for chatroom in allChatrooms.get("noahMinjiInitialDMs"):
				gameManager.add_chat(chatroom)
			gameManager.seenChats.append("noahMinjiInitialDMs")
			
			gameManager.friends.clear()
			gameManager.seenFriends.clear()
			for friend in allFriends.get("update1Friends"):
				gameManager.add_friend(friend)
			gameManager.seenFriends.append("update1Friends")
			
			gameManager.dayIndicator = "day4"
			dayNotification.display("Day Four")
		if ( ! gameManager.seenEmails.has("noahMinjiEmail") && gameManager.completedChats.has("NoahMinji-VanessaEmails") ):
			for email in allEmails.get("noahMinjiEmail"):
				gameManager.add_email(email)
			gameManager.seenEmails.append("noahMinjiEmail")
		# Search Unlock: Janice Walter & Tableaux
		if ( ! gameManager.completedChats.has("Calvin1-Translate") && gameManager.completedChats.has("NoahMinji-VanessaEmails")):
			gameManager.seenChats.append("calvinInitialDMs")
			gameManager.add_chat_segment(chatroomUpdates.get("calvinInitialDMs"), "Calvin")
		if ( ! gameManager.completedChats.has("James1-Translate") && gameManager.completedChats.has("Calvin1-Translate")):
			gameManager.seenChats.append("jamesInitialDMs")
			gameManager.add_chat_segment(chatroomUpdates.get("jamesInitialDMs"), "James")

func checkForNewEvidence(id:String):
	print("selected a thing " + id)
	print(gameManager.dayIndicator)
	var evidenceDict = evidencePlan.get(gameManager.dayIndicator)
	if ( evidenceDict != null ):
		var evidence = evidenceDict.get(id)
		if ( evidence != null && ! gameManager.evidences.contains(evidence)):
			gameManager.evidences.add_evidence(evidence)
			gameManager.obtainedEvidence.append(evidence.evidenceId)
