extends Panel

@onready var dayNotificationLabel = %DayNotification
@onready var dayNotificationTimer = %DayNotificationTimer

func display(label:String):
	show()
	print("displaying")
	dayNotificationLabel.text = label
	dayNotificationTimer.start()
	


func _on_day_notification_timer_timeout():
	hide()
