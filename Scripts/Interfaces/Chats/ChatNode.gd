extends HBoxContainer

@onready var nameField = $Message/Meta/Name
@onready var dateField = $Message/Meta/date
@onready var textField = $Message/Label
@onready var portraitNode = $Avatar

var speakerTag = "speaker"
var portraitTag = "portrait"
var dateTimeTag = "dateTime"
var nodeTagList = []

func populate(chatText = "", tagList = []):
	textField.text = chatText
	nodeTagList = tagList
	for tag in tagList:
		var splitTag = tag.split(":")
		if ( splitTag.size() != 2 ):
			print("tag could not be appropriately parsed" + tag)
		var tagKey = splitTag[0].strip_edges(true, true);
		var tagValue = splitTag[1].strip_edges(true, true);
		
		match(tagKey):
			speakerTag:
				nameField.text = tagValue
			portraitTag:
				portraitNode.texture = ResourceLoader.load("res://Sprites/" + tagValue + ".png")
			_:
				print("tag came in but is not currently being handled " + tag)

func getName():
	return nameField.text
	
func getTags():
	return nodeTagList

func getBodyText():
	return textField.text
	
func on_save_game(saved_data:Array[SavedData]):
	var my_data = SavedData.new()
	my_data.id = "blah"
	my_data.scene_path = scene_file_path
	
	saved_data.append(my_data)
	
func on_before_load_game():
	get_parent().remove_child(self)
	queue_free()
	
func on_load_game(saved_data:SavedData):
	#reset id and load data here
	pass
