extends HBoxContainer

@onready var icon = %Icon
@onready var evidenceSlotName = %evidenceSlotName
@onready var evidenceSlotDesc = %evidenceSlotDesc

# Called when the node enters the scene tree for the first time.
func display(evidence:Evidence):
	icon.texture = evidence.icon
	evidenceSlotName.text = evidence.evidenceTitle
	evidenceSlotDesc.text = evidence.description
