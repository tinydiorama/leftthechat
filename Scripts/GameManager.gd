class_name GameManager
extends Node

var savedId = "savedDataModels"

var emails:Emails = Emails.new()
var articles:Articles = Articles.new()
var friends:Friends = Friends.new()
var forums:Forums = Forums.new()
var chats:Chats = Chats.new()

var seenEmails:Array[String] = ["initialEmails"]
var seenFriends:Array[String] = ["initialFriends"]
var seenForums:Array[String] = ["initialForums"]
var seenChats:Array[String] = ["initialChatrooms"]

signal newEmail
signal newFriend
signal newForum
signal newChat

@onready var storyManager = %StoryManager

func add_email(email:Email):
	emails.add_email(email)

func add_friend(friend:Friend):
	friends.add_friend(friend)
	
func add_forum(thread:ForumThread):
	forums.add_thread(thread)
	
func add_chat(chat:Chatroom):
	chats.add_chatroom(chat)

func _ready():
	storyManager.addInitialContent()
	newEmail.emit()
	newFriend.emit()
	newForum.emit()
	newChat.emit()
	pass

func on_save_game(saved_data:Array[SavedData]):
	var my_data = GameSavedData.new()
	my_data.id = "savedDataModels"
	my_data.scene_path = scene_file_path
	my_data.parent_node = get_parent().get_path()
	my_data.seenChats = seenChats
	my_data.seenEmails = seenEmails
	my_data.seenForums = seenForums
	my_data.seenFriends = seenFriends
	
	saved_data.append(my_data)
	
func on_before_load_game():
	print("before load game")
	
func on_load_game(saved_data:SavedData):
	var my_data:GameSavedData = saved_data as GameSavedData
	
	seenChats = my_data.seenChats
	seenEmails = my_data.seenEmails
	seenForums = my_data.seenForums
	seenFriends = my_data.seenFriends
	
	populate_data()

func populate_data():
	for chatName in seenChats:
		var chatData = storyManager.allChatrooms.get(chatName)
		for chatroom in chatData:
			add_chat(chatroom)
	
	for emailName in seenEmails:
		var emailData = storyManager.allEmails.get(emailName)
		for email in emailData:
			add_email(email)
			
	for forumName in seenForums:
		var forumData = storyManager.allForums.get(forumName)
		for forum in forumData:
			add_forum(forum)
			
	for friendName in seenFriends:
		var friendData = storyManager.allFriends.get(friendName)
		for friend in friendData:
			add_friend(friend)
