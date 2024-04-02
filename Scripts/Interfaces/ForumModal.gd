extends MarginContainer

@export var forumThreadScene:PackedScene
@export var forumMainSubject:PackedScene
@export var forumPost:PackedScene

@onready var forumList = %ForumList
@onready var forumThreadPosts = %ForumThreadPosts
@onready var forumThreadList = %ForumThreadList
@onready var forumBodyPostList = %ForumBodyPostList
@onready var gameManager = get_node("/root/MainScreen/Utilities/GameManager")

var threads:Array[ForumThread] = []
var mouseOver = false
var currentThread:ForumThread

func openModal(allThreads):
	show()
	forumList.show()
	forumThreadPosts.hide()
	threads = allThreads
	populateThreads()

func populateThreads():
	for child in forumThreadList.get_children():
		child.queue_free()
		
	for thread in threads:
		var forum_thread = forumThreadScene.instantiate()
		forumThreadList.add_child(forum_thread)
		forum_thread.display(thread)
		forum_thread.connect("gui_input", Callable(self, "_on_gui_input").bind([thread]))
		forum_thread.connect("mouse_exited", Callable(self, "_on_mouse_exit"))

func _on_gui_input(event, params:Array):
	mouseOver = true
	currentThread = params[0]

func _on_mouse_exit():
	mouseOver = false
	
func _input(event):
	if event is InputEventMouseButton:
		if mouseOver == true:
			displayInnerThread()
			gameManager.unreadForums.erase(currentThread.subject)
			mouseOver = false

func displayInnerThread():
	forumList.hide()
	forumThreadPosts.show()
	for child in forumBodyPostList.get_children():
		child.queue_free()
		
	var forum_main_subject = forumMainSubject.instantiate()
	forumBodyPostList.add_child(forum_main_subject)
	forum_main_subject.display(currentThread)
	
	for post in currentThread.posts:
		var forum_post_body = forumPost.instantiate()
		forumBodyPostList.add_child(forum_post_body)
		forum_post_body.display(post)
	
func _on_close_button_pressed():
	gameManager.saveGame()
	hide()


func _on_back_button_pressed():
	forumList.show()
	populateThreads()
	gameManager.saveGame()
	forumThreadPosts.hide()
