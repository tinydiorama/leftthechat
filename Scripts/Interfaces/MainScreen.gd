extends Control

@onready var startupScreen = %Startup
@onready var mainGame = %MainGameNav
@onready var characterBuilder = %CharacterBuilder
@onready var characterBuilderModal = %CharacterBuilderModal
@onready var gameManager = %GameManager

func _ready():
	print("game ready")


func _on_game_manager_new_character_builder():
	if not characterBuilder: await self.ready
	characterBuilder.show()
	characterBuilderModal.display()
