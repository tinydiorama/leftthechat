extends NinePatchRect

@export var evidenceButtonScene:PackedScene

@onready var evidenceListUI = %EvidenceList
@onready var gameManager = get_node("/root/MainScreen/Utilities/GameManager")

var evidenceButtons = []
var currentEvidence:Evidence

signal evidenceSelected(evidenceToPresent:Evidence)

func populateModal():
	show()
	var evidenceList = gameManager.evidences.get_evidence()
	
	for child in evidenceListUI.get_children():
		child.queue_free()
		
	var i = 0
	
	for evidence in evidenceList:
		var evidenceButton = evidenceButtonScene.instantiate()
		evidenceButtons.append(evidenceButton)
		evidenceListUI.add_child(evidenceButton)
		evidenceButton.populateButton(evidence)
		if ( i == 0 ):
			evidenceButton.selectButton()
			currentEvidence = evidence
		evidenceButton.connect("pressed", Callable(self, "_onPressed").bind([evidence, evidenceButton]))
		i = i + 1

func _onPressed(params:Array):
	currentEvidence = params[0]	
	var currentEvidenceButton = params[1]
	
	for evidenceButton in evidenceButtons:
		if (evidenceButton == currentEvidenceButton):
			evidenceButton.selectButton()
		else:
			evidenceButton.unselectButton()


func _on_select_button_pressed():
	evidenceSelected.emit(currentEvidence)
	hide()
