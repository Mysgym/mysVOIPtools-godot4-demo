extends Node

# --- Create objects
@onready var resampler = AudioResampler.new()
@onready var decoder = GdOpusDecoder.new()

# --- Initialize resampler
func _ready():
	# initialize the resampler : From the opus sampling rate (48000) to the local mix rate. Quality=3 arbitrarily
	resampler.init(48000, AudioServer.get_mix_rate(), 3)


# --- On packet received
func _on_input_send_packet(packet : PackedByteArray):
	#decode the encoded packet
	var frame := decoder.decode(packet)
	#resample it to the local sampling rate
	frame = resampler.resample(frame)
	#Play it !
	$Output.get_stream_playback().push_buffer(frame)
