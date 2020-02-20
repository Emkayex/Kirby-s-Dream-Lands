extends HSlider

export var BusIndex = 0


func _ready():
	var _err = connect("value_changed", self, "_value_changed")
	
	max_value = Sound.MAX_SLIDER_VALUE
	value = round(db2linear(AudioServer.get_bus_volume_db(BusIndex)) * max_value)


func _value_changed(value):
	AudioServer.set_bus_volume_db(BusIndex, linear2db(value / max_value))