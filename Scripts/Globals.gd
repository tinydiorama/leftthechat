extends Node

var restaurantChoice:String
var playerFirstname:String
var playerUsername:String
var chatModal:Node
var gameManager:GameManager

func on_save_game(saved_data:Array[SavedData]):
	var my_data = GlobalsSavedData.new()
	my_data.id = "globalDataModels"
	my_data.scene_path = scene_file_path
	my_data.restaurantChoice = restaurantChoice
	my_data.playerHandle = playerUsername
	my_data.playerName = playerFirstname
	saved_data.append(my_data)

func on_load_game(saved_data:SavedData):
	var my_data:GlobalsSavedData = saved_data as GlobalsSavedData

	restaurantChoice = my_data.restaurantChoice
	playerUsername = my_data.playerHandle
	playerFirstname = my_data.playerName

func showEvidenceSelect():
	chatModal.showSelectEvidenceModal()

func dialogueBack():
	chatModal._on_chat_back()

func checkForEvidenceGet(id:String):
	gameManager.onSelectView(id)
