extends Node
class_name SoundPlayer

enum THEMES {
	THEME1,
	THEME2
}

@export var tracks = {
	THEMES.THEME1: [preload("res://Audio/chillandsoul.mp3"), preload("res://Audio/dreamscape.mp3")],
	THEMES.THEME2: []
}

@export var trackInfo = {
	THEMES.THEME1: [{
		"name": "Chill & Soul",
		"artist": "Lidérc"
	},
	{
		"name": "Dreamscape",
		"artist": "Lidérc"
	}],
	THEMES.THEME2: []
}

var current_theme:int = THEMES.THEME1
var is_repeating:bool = true
var currentTrackId:int

@onready var streamPlayer:AudioStreamPlayer = %AudioStreamPlayer

signal next_audio_track

func playSoundtrack(theme:int, repeatThemes:bool = true) -> Dictionary:
	if not streamPlayer: await self.ready
	if current_theme != theme || ! streamPlayer.playing:
		is_repeating = false
		streamPlayer.stop()
		is_repeating = repeatThemes
		current_theme = theme
		var themeTracks:Array = tracks[current_theme]
		if ( themeTracks != []):
			currentTrackId = randi() % themeTracks.size()
			streamPlayer.stream = themeTracks[currentTrackId]
			streamPlayer.play()
			return trackInfo[current_theme][currentTrackId]
	return {}

func playNext() -> Dictionary:
	var themeTracks:Array = tracks[current_theme]
	currentTrackId = currentTrackId + 1
	if ( currentTrackId >= themeTracks.size() ):
		currentTrackId = 0
	streamPlayer.stream = themeTracks[currentTrackId]
	streamPlayer.play()
	next_audio_track.emit()
	return trackInfo[current_theme][currentTrackId]

func playPrevious() -> Dictionary:
	var themeTracks:Array = tracks[current_theme]
	currentTrackId = currentTrackId - 1
	if ( currentTrackId < 0 ):
		currentTrackId = themeTracks.size() - 1
	streamPlayer.stream = themeTracks[currentTrackId]
	streamPlayer.play()
	next_audio_track.emit()
	return trackInfo[current_theme][currentTrackId]

func getSongInfo() -> Dictionary:
	return trackInfo[current_theme][currentTrackId]
	
func pause():
	if ( streamPlayer.stream_paused ):
		streamPlayer.stream_paused  = false
	else:
		streamPlayer.stream_paused  = true

func _on_audio_stream_player_finished():
	if ( is_repeating ):
		playNext()
		
func getAudioStatus() -> int:
	return streamPlayer.get_playback_position() / streamPlayer.stream.get_length() * 100
