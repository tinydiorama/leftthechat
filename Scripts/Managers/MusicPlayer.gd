extends VBoxContainer

@onready var soundPlayer:SoundPlayer = %SoundPlayer
@onready var currentSongInfo = %CurrentSong
@onready var progressBar = %SongProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	var trackInfo = await soundPlayer.playSoundtrack(0, true)
	currentSongInfo.text = trackInfo.name + " by " + trackInfo.artist


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progressBar.value = soundPlayer.getAudioStatus()


func _on_previous_pressed():
	soundPlayer.playPrevious()


func _on_next_pressed():
	soundPlayer.playNext()


func _on_play_pause_pressed():
	soundPlayer.pause()


func _on_sound_player_next_audio_track():
	var trackInfo = soundPlayer.getSongInfo()
	currentSongInfo.text = trackInfo.name + " by " + trackInfo.artist
