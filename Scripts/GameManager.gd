class_name GameManager
extends Node

var gameStarted:bool = false

var savedId = "savedDataModels"

var firstName:String = ""
var lastName:String = ""
var handle:String = ""
var directPronoun:String = "they"
var indirectPronoun:String = "them"
var avatar:Texture2D

var emails:Emails = Emails.new()
var articles:Articles = Articles.new()
var friends:Friends = Friends.new()
var forums:Forums = Forums.new()
var chats:Chats = Chats.new()
var evidences:Evidences = Evidences.new()

var seenEmails:Array[String] = ["initialEmails"]
var seenFriends:Array[String] = ["initialFriends"]
var seenForums:Array[String] = ["janiceWalkerVictim"]
var seenChats:Array[String] = ["initialChatrooms"]
var obtainedEvidence:Array[String] = []

var unreadEmails:Array[String] = []
var updatedFriends:Array[String] = []
var unreadForums:Array[String] = []
var unreadChats:Array[String] = []
var completedChats:Array[String] = []

var allChatHistory:Dictionary

var internetUnlocked:bool
var vanessaArticleRead:bool
var janiceArticleRead:bool
var wolfeInDisguiseArticleRead:bool
var cilbitoxinArticleRead:bool
var kingdomOfShadowsRead:bool
var dayIndicator:String
var presentEvidenceUnlocked:bool
var tableauxUnlocked:bool

signal newEmail
signal newFriend
signal newForum
signal newChat
signal newCharacterBuilder

@onready var storyManager = %StoryManager
@onready var saverLoader = %SaverLoader
@onready var characterBuilder = %CharacterBuilder
@onready var mainGameNav = %MainGameNav

func add_email(email:Email):
	emails.add_email(email)
	unreadEmails.append(email.subject)

func add_friend(friend:Friend):
	friends.add_friend(friend)
	
func add_forum(thread:ForumThread):
	forums.add_thread(thread)
	unreadForums.append(thread.subject)
	
func add_chat(chat:Chatroom):
	chats.add_chatroom(chat)
	unreadChats.append(chat.chatName)
	
func add_chat_segment(chatSegment:ChatMeta, chatName:String):
	chats.add_chat_segment(chatSegment, chatName)
	unreadChats.append(chatName)
	
func add_evidence(evidence:Evidence):
	evidences.add_evidence(evidence)
	if ( evidence != null && ! obtainedEvidence.has(evidence.evidenceId) ):
		obtainedEvidence.append(evidence.evidenceId)
		
func contains_evidence_id(id:String):
	return evidences.contains(storyManager.allEvidence.get(id))
		
func update_evidence(evidenceId:String, evidenceToObtainId:String):
	if ( evidences.contains(storyManager.allEvidence.get(evidenceId)) ):
		evidences.remove_evidence(storyManager.allEvidence.get(evidenceId))
		obtainedEvidence.erase(evidenceId)
		add_evidence(storyManager.allEvidence.get(evidenceToObtainId))
	
############################ Chat History
func addChatHistory(chatMessageName:String, id:String) -> Array:
	var arrayToAdd = []
	if ( allChatHistory.get(chatMessageName) != null ):
		arrayToAdd = allChatHistory.get(chatMessageName)
	else:
		allChatHistory[chatMessageName] = []
		arrayToAdd = allChatHistory[chatMessageName]
		
	if ( arrayToAdd.find(id) != -1 ): #already contains id
		return arrayToAdd
	else:
		arrayToAdd.append(id)
		return arrayToAdd
		
func deleteChatHistory(chatMessageName:String):
	if ( allChatHistory.get(chatMessageName) == null ):
		return #nothing to delete
	else:
		allChatHistory[chatMessageName] = []
		
	
func getChatHistory(chatMessageName:String) -> Array:
	return allChatHistory.get(chatMessageName)
		
func containsChatHistory(chatMessageName:String):
	return true if allChatHistory.find_key(chatMessageName) else false
	
func containsChatHistoryID(chatMessageName:String, id:String):
	if ( ! allChatHistory.find_key(chatMessageName) ):
		return false
	else:
		var arrayToCheck = allChatHistory.find_key(chatMessageName)
		return true if arrayToCheck.find_key(id) else false
########################### end chat history stuff

func isAllUnreads() -> bool:
	return (unreadChats.size() == 0) && (unreadEmails.size() == 0) && (unreadForums.size() == 0)

func _ready():
	saverLoader.load_game()
	Globals.gameManager = self
	
	if ( firstName == "" ):
		newCharacterBuilder.emit()
		
	if ( ! gameStarted ):
		dayIndicator = "day1"
		storyManager.addInitialContent()
		newEmail.emit()
		newFriend.emit()
		newForum.emit()
		newChat.emit()
	
func _on_character_builder_modal_character_submit(fullName, handleParam, pronouns, avatarParam):
	gameStarted = true
	var names = fullName.split(" ")
	firstName = names[0]
	Globals.playerFirstname = firstName
	if ( names.size() > 1 ):
		lastName = names[1]
	handle = handleParam
	Globals.playerUsername = handle
	if ( pronouns == "TheyCheckbox" ):
		directPronoun = "they"
		indirectPronoun = "them"
	elif ( pronouns == "SheCheckbox" ):
		directPronoun = "she"
		indirectPronoun = "her"
	else: #pronouns == "HeCheckbox"
		directPronoun = "he"
		indirectPronoun = "him"
	avatar = avatarParam
	saverLoader.save_game()
	characterBuilder.hide()
	
func onSelectView(id:String):
	print(id)
	storyManager.checkForNewEvidence(id)
	
func saveGame():
	# Check for game progress
	storyManager.advanceStory()
	saverLoader.save_game()

func on_save_game(saved_data:Array[SavedData]):
	var my_data = GameSavedData.new()
	my_data.id = "savedDataModels"
	my_data.scene_path = scene_file_path
	my_data.parent_node = get_parent().get_path()
	my_data.seenChats = seenChats
	my_data.seenEmails = seenEmails
	my_data.seenForums = seenForums
	my_data.seenFriends = seenFriends
	my_data.obtainedEvidence = obtainedEvidence
	my_data.firstName = firstName
	my_data.lastName = lastName
	my_data.handle = handle
	my_data.directPronoun = directPronoun
	my_data.indirectPronoun = indirectPronoun
	my_data.avatar = avatar
	my_data.gameStarted = gameStarted
	my_data.unreadEmails = unreadEmails
	my_data.updatedFriends = updatedFriends
	my_data.unreadForums = unreadForums
	my_data.unreadChats = unreadChats
	my_data.chatHistory = allChatHistory
	my_data.completedChats = completedChats
	my_data.internetUnlocked = internetUnlocked
	my_data.presentEvidenceUnlocked = presentEvidenceUnlocked
	my_data.internetSearchTerms = mainGameNav.getInternetUnlockedArticles()
	my_data.vanessaArticleRead = vanessaArticleRead
	my_data.janiceArticleRead = janiceArticleRead
	my_data.cilbitoxinArticleRead = cilbitoxinArticleRead
	my_data.wolfeInDisguiseArticleRead = wolfeInDisguiseArticleRead
	my_data.kingdomOfShadowsRead = kingdomOfShadowsRead
	my_data.tableauxUnlocked = tableauxUnlocked
	my_data.dayIndicator = dayIndicator
	saved_data.append(my_data)
	
func on_before_load_game():
	print("before load game")
	
func on_load_game(saved_data:SavedData):
	var my_data:GameSavedData = saved_data as GameSavedData
	
	seenChats = my_data.seenChats
	seenEmails = my_data.seenEmails
	seenForums = my_data.seenForums
	seenFriends = my_data.seenFriends
	obtainedEvidence = my_data.obtainedEvidence
	
	firstName = my_data.firstName
	lastName = my_data.lastName
	handle = my_data.handle
	directPronoun = my_data.directPronoun
	indirectPronoun = my_data.indirectPronoun
	avatar = my_data.avatar
	gameStarted = my_data.gameStarted
	unreadEmails = my_data.unreadEmails
	updatedFriends = my_data.updatedFriends
	unreadForums = my_data.unreadForums
	unreadChats = my_data.unreadChats
	allChatHistory = my_data.chatHistory
	completedChats = my_data.completedChats
	internetUnlocked = my_data.internetUnlocked
	presentEvidenceUnlocked = my_data.presentEvidenceUnlocked
	vanessaArticleRead = my_data.vanessaArticleRead
	janiceArticleRead = my_data.janiceArticleRead
	cilbitoxinArticleRead = my_data.cilbitoxinArticleRead
	wolfeInDisguiseArticleRead = my_data.wolfeInDisguiseArticleRead
	kingdomOfShadowsRead = my_data.kingdomOfShadowsRead
	tableauxUnlocked = my_data.tableauxUnlocked
	dayIndicator = my_data.dayIndicator
	
	mainGameNav.setInternetUnlockedArticles(my_data.internetSearchTerms)
	
	populate_data()

func populate_data():
	for chatName in seenChats:
		var chatData = storyManager.allChatrooms.get(chatName)
		if ( chatData != null ):
			for chatroom in chatData:
				chats.add_chatroom(chatroom)
				
	for chatName in seenChats:
		var chatData = storyManager.chatroomUpdates.get(chatName)
		if ( chatData == null ):
			chatData = storyManager.chatroomUpdates2.get(chatName)
		if ( chatData != null ):
			var chatroomName = chatData.chatroomName
			chats.add_chat_segment(chatData, chatData.chatroomName)
	
	for emailName in seenEmails:
		var emailData = storyManager.allEmails.get(emailName)
		for email in emailData:
			emails.add_email(email)
			
	for forumName in seenForums:
		var forumData = storyManager.allForums.get(forumName)
		forums.add_thread(forumData)
			
	for friendName in seenFriends:
		var friendData = storyManager.allFriends.get(friendName)
		for friend in friendData:
			add_friend(friend)
			
	for evidenceName in obtainedEvidence:
		var evidenceData = storyManager.allEvidence.get(evidenceName)
		add_evidence(evidenceData)
			
	if internetUnlocked:
		mainGameNav.showInternet()
		
	if tableauxUnlocked:
		mainGameNav.showTableaux()

func unlockTableaux():
	tableauxUnlocked = true
	mainGameNav.closeInternetModal()
	mainGameNav._on_forum_button_pressed()
	mainGameNav.showTableaux()

func _on_internet_modal_vanessa_article_read():
	vanessaArticleRead = true
	add_evidence(storyManager.allEvidence.get("vanessaDeath"))

func _on_internet_modal_janice_walker_article_read():
	janiceArticleRead = true

func _on_internet_modal_cilbitoxin_article_read():
	cilbitoxinArticleRead = true

func _on_internet_modal_wolfe_in_disguise():
	wolfeInDisguiseArticleRead = true
	update_evidence("updatedLatinPhrase", "updatedLatinPhrase2")
	add_evidence(storyManager.allEvidence.get("vanessaPaigeFight"))

func _on_internet_modal_kingdom_of_shadows():
	kingdomOfShadowsRead = true
	update_evidence("updatedLatinPhrase2", "updatedLatinPhrase3")
	add_evidence(storyManager.allEvidence.get("kingdomOfShadows"))
