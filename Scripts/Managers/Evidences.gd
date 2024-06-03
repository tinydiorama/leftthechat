class_name Evidences

var _content:Array[Evidence] = []

func add_evidence(evidence:Evidence):
	if ( ! _content.has(evidence) ):
		_content.push_back(evidence)

func remove_evidence(evidence:Evidence):
	_content.erase(evidence)
	
func contains(evidence:Evidence) -> bool:
	return _content.has(evidence)
	
func get_evidence() -> Array[Evidence]:
	return _content
