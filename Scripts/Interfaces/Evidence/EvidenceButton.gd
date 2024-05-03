extends TextureButton

@onready var evidenceSlot = %EvidenceSlot

func populateButton(evidence:Evidence):
	evidenceSlot.display(evidence)
	
func selectButton():
	texture_normal = texture_pressed
	
func unselectButton():
	texture_normal = null
