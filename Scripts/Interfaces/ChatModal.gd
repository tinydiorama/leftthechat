extends NinePatchRect

@onready var chatSelection = %ChatSelection
@onready var chatStoryPlayer = %ChatStoryPlayer
@onready var gameManager = %GameManager
@onready var closeButton = %ChatCloseButton
@onready var selectEvidenceModal = %SelectEvidence

@export var evidencePlan:Dictionary
var relevantChat:String
	
var chats:Array[Chatroom] = []

func _ready():
	Globals.chatModal = self

func openModal(allChats):
	show()
	chatSelection.show()
	chatStoryPlayer.hide()
	chats = allChats
	populateChatSelection()
	
func populateChatSelection():
	chatSelection.displayChats(chats)

func _on_chat_selected(chat):
	chatSelection.hide()
	relevantChat = chat.chatName
	gameManager.onSelectView(chat.chatId)
	chatStoryPlayer.show()
	chatStoryPlayer.showChat(chat, gameManager)

func _on_close_button_pressed():
	gameManager.saveGame()
	self.hide()

func _on_chat_back():
	gameManager.saveGame()
	chatSelection.show()
	chatStoryPlayer.hide()
	closeButton.disabled = false
	populateChatSelection()


func _on_chat_story_player_chat_playing():
	closeButton.disabled = true


func _on_day_notification_day_notification_display():
	_on_close_button_pressed()

func showSelectEvidenceModal():
	selectEvidenceModal.populateModal()


func _on_select_evidence_evidence_selected(evidenceToPresent:Evidence):
	var evidenceSegment = evidencePlan.get(gameManager.dayIndicator)
	print(gameManager.dayIndicator)
	var evidenceDialogue = evidenceSegment.get(relevantChat).get(evidenceToPresent.evidenceId)
	if ( evidenceDialogue != null):
		chatStoryPlayer.playDialogueDirect(evidenceDialogue)
	else:
		evidenceDialogue = evidencePlan.get("defaults").get(relevantChat)
		chatStoryPlayer.playDialogueDirect(evidenceDialogue)
