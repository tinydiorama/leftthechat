class_name Articles

var _content:Array[Article] = []

func add_article(article:Article):
	_content.append(article)

func remove_article(article:Article):
	_content.erase(article)
	
func get_articles() -> Array[Article]:
	return _content
