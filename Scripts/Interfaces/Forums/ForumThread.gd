extends PanelContainer

@onready var postAvatar = %PostAvatar
@onready var postUsername = %PostUsername
@onready var postSubject = %PostSubject
@onready var upvotes = %Upvotes
@onready var comments = %Comments

func display(forumThread:ForumThread):
	postUsername.text = forumThread.originalPoster
	postAvatar.texture = forumThread.avatar
	postSubject.text = forumThread.subject
	upvotes.text = str(forumThread.upvotes)
	comments.text = str(forumThread.posts.size())
