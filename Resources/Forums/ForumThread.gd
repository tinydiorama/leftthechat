class_name ForumThread
extends Resource

@export var subject:String
@export var originalPoster:String
@export var avatar:Texture2D
@export var upvotes:int
@export var posts:Array[ForumPost]
@export_multiline var body:String
