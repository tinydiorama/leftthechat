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
@onready var internetModal = %InternetModal

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
		if ( ! gameManager.completedChats.has("Minji-2-Invite") && gameManager.seenEmails.has("initialEmails") && gameManager.seenChats.has("initialChatrooms") && gameManager.seenForums.has("janiceWalkerVictim")):
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
		# Day 3
		if ( ! gameManager.completedChats.has("Horror6-NoOneCameForward") && gameManager.completedChats.has("Paige1-Suspicious")):
			gameManager.add_chat_segment(chatroomUpdates.get("horrorNoOneCameForward"), "Horror Fanatics - General")
			gameManager.seenChats.append("horrorNoOneCameForward")
		# DAY 4
		if ( ! gameManager.completedChats.has("NoahMinji-VanessaEmails") && gameManager.completedChats.has("Horror6-NoOneCameForward")):
			for chatroom in allChatrooms.get("noahMinjiInitialDMs"):
				gameManager.add_chat(chatroom)
			gameManager.seenChats.append("noahMinjiInitialDMs")
			
			gameManager.seenChats.append("horror7SheWasntASaint")
			gameManager.add_chat_segment(chatroomUpdates.get("horror7SheWasntASaint"), "Horror Fanatics - General")
			
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
		if ( ! gameManager.completedChats.has("Calvin1-Professor") && gameManager.completedChats.has("NoahMinji-VanessaEmails") && gameManager.seenEmails.has("noahMinjiEmail")):
			gameManager.seenChats.append("calvinInitialDMs")
			gameManager.add_chat_segment(chatroomUpdates.get("calvinInitialDMs"), "Calvin")
		if ( gameManager.completedChats.has("Calvin1-Professor") ):
			gameManager.presentEvidenceUnlocked = true
		if ( ! gameManager.completedChats.has("James1-Translate") && gameManager.contains_evidence_id("updatedLatinPhrase")):
			gameManager.seenChats.append("jamesInitialDMs")
			gameManager.add_chat_segment(chatroomUpdates.get("jamesInitialDMs"), "James")
		
	if ( gameManager.dayIndicator == "day4" && gameManager.seenEmails.has("noahMinjiEmail")):
		internetModal.add_option("Janice Walker")
	if ( gameManager.dayIndicator == "day4" && gameManager.completedChats.has("James1-Translate")):
		gameManager.seenChats.append("mom3")
		gameManager.add_chat_segment(chatroomUpdates.get("mom3"), "Mom")
		gameManager.seenChats.append("horror8Awkward")
		gameManager.add_chat_segment(chatroomUpdates.get("horror8Awkward"), "Horror Fanatics - General")
		gameManager.seenChats.append("minji6AnotherEmail")
		gameManager.add_chat_segment(chatroomUpdates.get("minji6AnotherEmail"), "Minji")
		gameManager.dayIndicator = "day5"
		dayNotification.display("Day Five")
		
	if ( gameManager.dayIndicator == "day5"):
		if ( ! gameManager.seenEmails.has("minjiAreYouOneOfUs") && gameManager.completedChats.has("Minji6-AnotherEmail") ):
			for email in allEmails.get("minjiAreYouOneOfUs"):
				gameManager.add_email(email)
			gameManager.seenEmails.append("minjiAreYouOneOfUs")
		if ( gameManager.unreadEmails.size() == 0 && gameManager.seenEmails.has("minjiAreYouOneOfUs") && ! gameManager.seenChats.has("minji7FreakedOut")):
			gameManager.seenChats.append("minji7FreakedOut")
			gameManager.add_chat_segment(chatroomUpdates.get("minji7FreakedOut"), "Minji")
		if ( gameManager.isAllUnreads() && gameManager.seenEmails.has("minjiAreYouOneOfUs") && gameManager.completedChats.has("Minji7-FreakedOut")):
			gameManager.seenChats.append("dad2")
			gameManager.add_chat_segment(chatroomUpdates.get("dad2"), "Dad")
			gameManager.seenChats.append("james2Awkward")
			gameManager.add_chat_segment(chatroomUpdates.get("james2Awkward"), "James")
			gameManager.seenChats.append("minji8AnotherEmail2")
			gameManager.add_chat_segment(chatroomUpdates.get("minji8AnotherEmail2"), "Minji")
			gameManager.dayIndicator = "day6"
			dayNotification.display("Day Six")
			
	if ( gameManager.dayIndicator == "day6"):
		if ( ! gameManager.seenEmails.has("minjiVanessaEmail3") && gameManager.completedChats.has("Minji8-AnotherEmail2") ):
			for email in allEmails.get("minjiVanessaEmail3"):
				gameManager.add_email(email)
			gameManager.seenEmails.append("minjiVanessaEmail3")
		if ( gameManager.unreadEmails.size() == 0 && gameManager.seenEmails.has("minjiVanessaEmail3") && ! gameManager.seenChats.has("minji9MomDiagnosis")):
			gameManager.seenChats.append("minji9MomDiagnosis")
			gameManager.add_chat_segment(chatroomUpdates.get("minji9MomDiagnosis"), "Minji")
		if ( gameManager.isAllUnreads() && gameManager.completedChats.has("Minji9-MomDiagnosis") ):
			gameManager.seenChats.append("horror9ClearAir")
			gameManager.add_chat_segment(chatroomUpdates.get("horror9ClearAir"), "Horror Fanatics - General")
			gameManager.dayIndicator = "day7"
			dayNotification.display("Day Seven")
			
	if ( gameManager.dayIndicator == "day7" ):
		if ( gameManager.completedChats.has("Horror9-ClearAir") ):
			gameManager.seenChats.append("paige2StopEmailing")
			gameManager.add_chat_segment(chatroomUpdates.get("paige2StopEmailing"), "Paige")
			gameManager.seenChats.append("amelia1HoldingUp")
			gameManager.add_chat_segment(chatroomUpdates.get("amelia1HoldingUp"), "Amelia")
			gameManager.forums.add_thread(allForums.get("newGhostGirlMurder"))
			gameManager.seenForums.append("newGhostGirlMurder")
			
		if ( ! gameManager.unreadForums.has("newGhostGirlMurder") && gameManager.seenForums.has("newGhostGirlMurder") ):
			internetModal.add_option("cilbitoxin")
			
		if ( gameManager.isAllUnreads() && gameManager.cilbitoxinArticleRead ):
			gameManager.seenChats.append("minji10FeelingWeird")
			gameManager.add_chat_segment(chatroomUpdates.get("minji10FeelingWeird"), "Minji")
			
		if ( gameManager.isAllUnreads() && gameManager.completedChats.has("Minji10-FeelingWeird") ):
			gameManager.seenChats.append("mom4")
			gameManager.add_chat_segment(chatroomUpdates.get("mom4"), "Mom")
			gameManager.seenChats.append("horror10EternalAffliction")
			gameManager.add_chat_segment(chatroomUpdates.get("horror10EternalAffliction"), "Horror Fanatics - General")
			gameManager.dayIndicator = "day8"
			dayNotification.display("Day Eight")
			
	if ( gameManager.dayIndicator == "day8" ):
		if ( gameManager.seenForums.has("vanessaWolfeSecretBlog") && gameManager.unreadForums.size() == 0):
			internetModal.add_option("Wolfe in Disguise")
			
		if ( gameManager.wolfeInDisguiseArticleRead && ! gameManager.internetSearchTerms.has("in morte ero eius") ):
			internetModal.add_option("in morte ero eius")
			
		if ( gameManager.kingdomOfShadowsRead && ! gameManager.seenChats.has("horror11KingdomOfShadows")):
			gameManager.seenChats.append("horror11KingdomOfShadows")
			gameManager.add_chat_segment(chatroomUpdates.get("horror11KingdomOfShadows"), "Horror Fanatics - General")
			

func checkForNewEvidence(id:String):
	var evidenceDict = evidencePlan.get(gameManager.dayIndicator)
	if ( evidenceDict != null ):
		var evidence = evidenceDict.get(id)
		if ( typeof(evidence) == TYPE_ARRAY ):
			for evidencePiece in evidence:
				if ( evidencePiece != null && ! gameManager.evidences.contains(evidencePiece)):
					gameManager.add_evidence(evidencePiece)
		else:
			if ( evidence != null && ! gameManager.evidences.contains(evidence)):
				gameManager.add_evidence(evidence)
