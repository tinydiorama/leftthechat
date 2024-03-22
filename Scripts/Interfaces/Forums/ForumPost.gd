extends PanelContainer

@onready var postAvatar = %PostAvatar
@onready var postUsername = %PostUsername
@onready var postBody = %PostBody

func display(forumPost:ForumPost):
	postUsername.text = forumPost.username
	postAvatar.texture = forumPost.avatar
	postBody.text = forumPost.body
