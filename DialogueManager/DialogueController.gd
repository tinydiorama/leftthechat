extends BoxContainer

## The action to use for advancing the dialogue
const NEXT_ACTION = &"ui_accept"

## The action to use to skip typing the dialogue
const SKIP_ACTION = &"ui_cancel"

@onready var responses_menu: DialogueResponsesMenu = %ResponsesMenu
@onready var chatMessageContainer = $ScrollContainer/ChatMessages
var chatNode = load("res://DialogueManager/ChatNode.tscn")

## The dialogue resource
var resource: DialogueResource

## Temporary game states
var temporary_game_states: Array = []

## See if we are waiting for the player
var is_waiting_for_input: bool = false

## See if we are running a long mutation and should hide the balloon
var will_hide_balloon: bool = false

var currentChatNode

var allChatNodes: Array[Dictionary] = []

var savedId = "blah"

## The current line
var dialogue_line: DialogueLine:
	set(next_dialogue_line):
		is_waiting_for_input = false

		# The dialogue has finished so close the balloon
		if not next_dialogue_line:
			queue_free()
			return

		# If the node isn't ready yet then none of the labels will be ready yet either
		if not is_node_ready():
			await ready

		dialogue_line = next_dialogue_line
		
		#var lkjdf = await DialogueManager.get_line(load("res://Resources/Dialogue/test.dialogue"), next_dialogue_line.id, [])
		#print(lkjdf)
		var currentLine:Dictionary = { resource.get_path(): next_dialogue_line.id}
		allChatNodes.append(currentLine)
		#print(next_dialogue_line.id)
		
		currentChatNode = chatNode.instantiate()
		chatMessageContainer.add_child(currentChatNode)

		currentChatNode.populate(dialogue_line)

		responses_menu.hide()
		responses_menu.set_responses(dialogue_line.responses)
		
		# Show our balloon
		will_hide_balloon = false

		# Wait for input
		if dialogue_line.responses.size() > 0:
			currentChatNode.focus_mode = Control.FOCUS_NONE
			responses_menu.show()
		elif dialogue_line.time != "":
			var time = dialogue_line.text.length() * 0.02 if dialogue_line.time == "auto" else dialogue_line.time.to_float()
			await get_tree().create_timer(time).timeout
			next(dialogue_line.next_id)
		else:
			is_waiting_for_input = true
			currentChatNode.focus_mode = Control.FOCUS_ALL
			currentChatNode.grab_focus()
	get:
		return dialogue_line


func _ready() -> void:
	Engine.get_singleton("DialogueManager").mutated.connect(_on_mutated)


func _unhandled_input(_event: InputEvent) -> void:
	# Only the balloon is allowed to handle input while it's showing
	get_viewport().set_input_as_handled()


## Start some dialogue
func start(dialogue_resource: DialogueResource, title: String, extra_game_states: Array = []) -> void:
	temporary_game_states =  [self] + extra_game_states
	is_waiting_for_input = false
	resource = dialogue_resource
	self.dialogue_line = await resource.get_next_dialogue_line(title, temporary_game_states)


## Go to the next line
func next(next_id: String) -> void:
	self.dialogue_line = await resource.get_next_dialogue_line(next_id, temporary_game_states)

func _on_balloon_gui_input(event: InputEvent) -> void:
	# See if we need to skip typing of the dialogue
	if currentChatNode != null && currentChatNode.dialogue_label.is_typing:
		var mouse_was_clicked: bool = event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed()
		var skip_button_was_pressed: bool = event.is_action_pressed(SKIP_ACTION)
		if mouse_was_clicked or skip_button_was_pressed:
			get_viewport().set_input_as_handled()
			currentChatNode.dialogue_label.skip_typing()
			return

	if not is_waiting_for_input: return
	if dialogue_line.responses.size() > 0: return

	# When there are no response options the balloon itself is the clickable thing
	get_viewport().set_input_as_handled()

	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		next(dialogue_line.next_id)
	elif event.is_action_pressed(NEXT_ACTION):
		next(dialogue_line.next_id)
		
### Signals


func _on_mutated(_mutation: Dictionary) -> void:
	is_waiting_for_input = false

func _on_responses_menu_response_selected(response: DialogueResponse) -> void:
	#todo add player choice into the actual game
	currentChatNode = chatNode.instantiate()
	chatMessageContainer.add_child(currentChatNode)

	currentChatNode.showResponse(response)
	next(response.next_id)

func on_save_game(saved_data:Array[SavedData]):
	var my_data = ChatSavedData.new()
	my_data.id = "blah"
	my_data.scene_path = scene_file_path
	my_data.chatsSeen = allChatNodes
	
	saved_data.append(my_data)
	
func on_before_load_game():
	get_parent().remove_child(self)
	queue_free()
	
func on_load_game(saved_data:SavedData):
	#var lkjdf = await DialogueManager.get_line(load("res://Resources/Dialogue/test.dialogue"), next_dialogue_line.id, [])
	#print(lkjdf)
	pass
