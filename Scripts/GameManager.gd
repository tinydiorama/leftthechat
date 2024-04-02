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

var seenEmails:Array[String] = ["initialEmails"]
var seenFriends:Array[String] = ["initialFriends"]
var seenForums:Array[String] = ["initialForums"]
var seenChats:Array[String] = ["initialChatrooms"]

var unreadEmails:Array[String] = []
var updatedFriends:Array[String] = []
var unreadForums:Array[String] = []

var allChatHistory:Dictionary

signal newEmail
signal newFriend
signal newForum
signal newChat
signal newCharacterBuilder

@onready var storyManager = %StoryManager
@onready var saverLoader = %SaverLoader
@onready var characterBuilder = %CharacterBuilder

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


func _ready():
	saverLoader.load_game()
	
	if ( firstName == "" ):
		newCharacterBuilder.emit()
		
	if ( ! gameStarted ):
		storyManager.addInitialContent()
		newEmail.emit()
		newFriend.emit()
		newForum.emit()
		newChat.emit()
	
func _on_character_builder_modal_character_submit(fullName, handleParam, pronouns, avatarParam):
	gameStarted = true
	var names = fullName.split(" ")
	firstName = names[0]
	lastName = names[1]
	handle = handleParam
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
	
func saveGame():
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
	
	saved_data.append(my_data)
	
func on_before_load_game():
	print("before load game")
	
func on_load_game(saved_data:SavedData):
	var my_data:GameSavedData = saved_data as GameSavedData
	
	seenChats = my_data.seenChats
	seenEmails = my_data.seenEmails
	seenForums = my_data.seenForums
	seenFriends = my_data.seenFriends
	
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
	
	populate_data()

func populate_data():
	for chatName in seenChats:
		var chatData = storyManager.allChatrooms.get(chatName)
		for chatroom in chatData:
			add_chat(chatroom)
	
	for emailName in seenEmails:
		var emailData = storyManager.allEmails.get(emailName)
		for email in emailData:
			emails.add_email(email)
			
	for forumName in seenForums:
		var forumData = storyManager.allForums.get(forumName)
		for forum in forumData:
			forums.add_thread(forum)
			
	for friendName in seenFriends:
		var friendData = storyManager.allFriends.get(friendName)
		for friend in friendData:
			add_friend(friend)


