extends MarginContainer

@onready var internetDropdown = %InternetDropdown
@onready var mainSearch = %MainSearchPage
@onready var searchResult = %SearchResult
@onready var articleContainer = %ArticleContainer
@onready var gameManager = get_node("/root/MainScreen/Utilities/GameManager")

@export var searchResults:Array

signal vanessaArticleRead

func display():
	show()
	mainSearch.show()
	searchResult.hide()

func _on_close_button_pressed():
	gameManager.saveGame()
	self.hide()

func _on_option_button_item_selected(index):
	mainSearch.hide()
	searchResult.show()
	
	for child in articleContainer.get_children():
		child.queue_free()
	
	var scene = searchResults[index]
	var instance = scene.instantiate()
	articleContainer.add_child(instance)
	
	if ( index == 0 ):
		vanessaArticleRead.emit()

func add_option(itemName:String):
	internetDropdown.add_item(itemName)


func _on_back_button_pressed():
	mainSearch.show()
	searchResult.hide()
	gameManager.saveGame()
