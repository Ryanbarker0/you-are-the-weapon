extends Node

signal SFX_VOLUME_UPDATED(new_value)
signal MUSIC_VOLUME_UPDATED(new_value)

enum AudioBusChannels { Master, Music, SFX }

var master_volume = 0.5:
	set(value):
		if (master_volume != value):
			master_volume = value
			set_bus_volume(AudioBusChannels.Master, master_volume)

var music_volume = 1.0:
	set(value):
		if (music_volume != value):
			music_volume = value
			set_bus_volume(AudioBusChannels.Music, music_volume)

var sfx_volume = 1.0:
	set(value):
		if (sfx_volume != value):
			sfx_volume = value
			set_bus_volume(AudioBusChannels.SFX, sfx_volume)

func set_bus_volume(bus, value):
	var volume_db = -72.0 - (-72.0 * value)
	AudioServer.set_bus_volume_db(bus, volume_db)
