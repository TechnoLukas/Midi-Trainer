extends Control
# The MIDI Input specific parts...

const SHADER = preload("res://pressedM.tres")
#@export var keys = 
#@export (Array, NodePath) var key

func _ready():
	OS.open_midi_inputs() # Required for cross-platform reliability.
	print(OS.get_connected_midi_inputs()) # List available MIDI input sources (e.g. keyboard, controller).
	$Label.text=str(OS.get_connected_midi_inputs())

func _unhandled_input(event : InputEvent):
	if (event is InputEventMIDI): 

		var event_dump_rb : String = ""
		event_dump_rb += "chn: {channel} msg: {message}\n".format({"channel": event.channel, "message": event.message})
		event_dump_rb += "  pitch: {pitch} vel: {velocity}\n".format({"pitch": event.pitch, "velocity": event.velocity})
		event_dump_rb += "\n"

		var keynum
		
		if event.message==9 and event.velocity>0: #Walkaround for MIDI_MESSAGE_NOTE_ON
			print(event.pitch,"ON")
			keynum="keyboard_background/keyboard/key"+str(event.pitch-35)
			get_node(keynum).set_material(SHADER)
		elif event.message==9 and event.velocity==0: #Walkaround for MIDI_MESSAGE_NOTE_OFF
			print(event.pitch,"OFF")
			keynum="keyboard_background/keyboard/key"+str(event.pitch-35) #Just to be sure that it is proper key...
			get_node(keynum).set_material(null)
			
			
		#match event.message:
		#	MIDI_MESSAGE_NOTE_ON:
		#		
		#		print(event.pitch,"ON")
		#		keynum="keyboard_background/keyboard/key"+str(event.pitch-35)
		#		get_node(keynum).set_material(SHADER)

			#MIDI_MESSAGE_NOTE_OFF:
			#	print(event.pitch,"OFF")
			#	keynum="keyboard_background/keyboard/key"+str(event.pitch-35) #Just to be sure that it is proper key...
			#	get_node(keynum).set_material(null)
