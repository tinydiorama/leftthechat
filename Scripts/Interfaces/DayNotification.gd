extends Panel

@onready var dayNotificationLabel = %DayNotification
@onready var dayNotificationTimer = %DayNotificationTimer

signal dayNotificationDisplay

func display(label:String):
	show()
	dayNotificationLabel.text = label
	dayNotificationTimer.start()
	dayNotificationDisplay.emit()
	


func _on_day_notification_timer_timeout():
	hide()
