extends MarginContainer


@export var evidenceScene:PackedScene
@onready var evidenceListUI = %EvidenceList
@onready var gameManager = get_node("/root/MainScreen/Utilities/GameManager")

var evidences:Array[Evidence] = []

# Called when the node enters the scene tree for the first time.
func openModal(evidenceList):
	evidences = evidenceList
	populateEvidence()
	show()


func _on_close_button_pressed():
	self.hide()
	gameManager.saveGame()

func populateEvidence():
	show()
	
	for child in evidenceListUI.get_children():
		child.queue_free()
	
	for evidence in evidences:
		var evidenceSlot = evidenceScene.instantiate()
		evidenceListUI.add_child(evidenceSlot)
		evidenceSlot.display(evidence)
