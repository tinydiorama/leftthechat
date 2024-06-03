extends MarginContainer

@onready var internetDropdown = %InternetDropdown
@onready var mainSearch = %MainSearchPage
@onready var searchResult = %SearchResult
@onready var articleContainer = %ArticleContainer
@onready var gameManager = get_node("/root/MainScreen/Utilities/GameManager")

@export var searchResults:Array
@export var optionLabels:Array = ["Vanessa Wolfe"]

signal vanessaArticleRead
signal janiceWalkerArticleRead
signal cilbitoxinArticleRead
signal wolfeInDisguise
signal kingdomOfShadows

func display():
	show()
	mainSearch.show()
	searchResult.hide()

func _on_close_button_pressed():
	internetDropdown.select(-1)
	mainSearch.show()
	searchResult.hide()
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
		gameManager.onSelectView("vanessaArticle")
		vanessaArticleRead.emit()
	if ( index == 1 ):
		gameManager.onSelectView("janiceArticle")
		janiceWalkerArticleRead.emit()
	if ( index == 2 ):
		gameManager.onSelectView("cilbitoxinArticle")
		cilbitoxinArticleRead.emit()
	if ( index == 3 ):
		gameManager.onSelectView("wolfeInDisguise")
		wolfeInDisguise.emit()
	if ( index == 4 ):
		gameManager.onSelectView("kingdomOfShadows")
		kingdomOfShadows.emit()

func add_option(itemName:String):
	if ( optionLabels.has(itemName) ):
		return
	internetDropdown.add_item(itemName)
	optionLabels.append(itemName)

func initializeDropdownFromSave(articlesToSet:Array):
	optionLabels = articlesToSet
	internetDropdown.clear()
	for label in optionLabels:
		internetDropdown.add_item(label)
	internetDropdown.select(-1)

func _on_back_button_pressed():
	internetDropdown.select(-1)
	mainSearch.show()
	searchResult.hide()
	gameManager.saveGame()
