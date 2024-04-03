class_name SaverLoader
extends Node

func save_game():	
	var saved_game:SavedGame = SavedGame.new()
	
	saved_game.day = 0
	
	var saved_data:Array[SavedData] = []
	get_tree().call_group("gameEvents", "on_save_game", saved_data)
	Globals.on_save_game(saved_data)
	saved_game.saveData = saved_data
	
	ResourceSaver.save(saved_game, "user://savegame.tres")
	
func load_game():
	var saved_game:SavedGame = SafeResourceLoader.load("user://savegame.tres") as SavedGame
	
	if saved_game == null:
		print("Saved game was unsafe!")
		return
		
	for savedData in saved_game.saveData:
		if ( savedData.id == "globalDataModels"):
			Globals.on_load_game(savedData)
	
	get_tree().call_group("gameEvents", "on_before_load_game")
	
	for savedNode in get_tree().get_nodes_in_group("gameEvents"):
		var savedId = savedNode.savedId
		
		for savedData in saved_game.saveData:
			if ( savedData.id == savedId ):
				savedNode.call("on_load_game", savedData)
				break
	
	#for item in saved_game.saveData:
		#if ( item.scene_path != null ):
			#var scene = load(item.scene_path) as PackedScene
			#
			#var restored_node = scene.instantiate()
			#world_root.add_child(restored_node)
			#
			#if ( restored_node.has_method("on_load_game") ):
				#restored_node.on_load_game(item)
			
