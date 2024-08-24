extends Node

# --- This demo sends packet using signals, unrelated to the tools
signal sendPacket

# --- Create objects
@onready var denoiser := AudioDenoiser.new()
@onready var resampler := Resampler.new()
@onready var encoder := GdOpusEncoder.new()

#size to input in the resampler to get a correctly size packet for opus (and denoiser, if default configuration)
@onready var resamplerInputSize := encoder.get_resampler_input_size()

# --- Get capture effect
@onready var capture = AudioServer.get_bus_effect(AudioServer.get_bus_index("MicIn"), 0) as AudioEffectCapture

# --- Initialize resampler
func _ready():
	#resampler from the local mix rate to the 48kHz needed by the encoder and denoiser. Quality = 3 arbitrary
	resampler.init(AudioServer.get_mix_rate(), 48000, 3)

# --- 
func _process(_delta):
	#get the buffer
	while(capture.can_get_buffer(resamplerInputSize)):
		var frame := capture.get_buffer(resamplerInputSize)
		#turn the signal into 48kHz sampling rate, needed for opus and denoiser (on default configuration)
		frame = resampler.resample(frame)
		#denoiser
		frame = denoise(frame)
		#opus encode and send
		var packet := encoder.encode(frame)
		send(packet)


func denoise(frame : PackedVector2Array) -> PackedVector2Array:
	#convert to mono, only format supported by rnnoise. Mode=2 averages left and right signal into one
	var mono := denoiser.stereo_to_mono(frame, 2)
	#denoise the mono signal
	mono = denoiser.process_frame(mono)
	#back to stereo
	return denoiser.mono_to_stereo(mono,mono)


#Send the packet however you see fit, this demo keeps it in the local scene to simplify
func send(packet : PackedByteArray):
	sendPacket.emit(packet)
