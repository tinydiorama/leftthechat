extends PanelContainer

@onready var postAvatar = %PostAvatar
@onready var postUsername = %PostUsername
@onready var postSubject = %PostSubject
@onready var upvotes = %Upvotes
@onready var comments = %Comments
@onready var newFlag = %NewFlag
@onready var gameManager = get_node("/root/MainScreen/Utilities/GameManager")

func display(forumThread:ForumThread):
	postUsername.text = forumThread.originalPoster
	postAvatar.texture = forumThread.avatar
	postSubject.text = forumThread.subject
	upvotes.text = str(forumThread.upvotes)
	comments.text = str(forumThread.posts.size())
	if ( gameManager.unreadForums.has(forumThread.subject) ):
		newFlag.show()
	else:
		newFlag.hide()
