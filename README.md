# MidiTrainer

Godot 4. Visualises typing on MIDI keyboard.

## Godot 4. Midi walkaround.

Just for now is an explanation for the issue with the missing event MIDI_MESSAGE_NOTE_OFF.
The walkaround is to check not only the `event.message` but additionally the `event.velocity` assuming that in the case of OFF the velocity is 0:

```gdscript
if event.message==9 and event.velocity>0: #Walkaround for MIDI_MESSAGE_NOTE_ON
    print(event.pitch,"ON")
    keynum="keyboard_background/keyboard/key"+str(event.pitch-35)
	get_node(keynum).set_material(SHADER)
elif event.message==9 and event.velocity==0: #Walkaround for MIDI_MESSAGE_NOTE_OFF
	print(event.pitch,"OFF")
    keynum="keyboard_background/keyboard/key"+str(event.pitch-35) #Just to be sure that it is proper key...
	get_node(keynum).set_material(null)
```

No such issue on Godot 3.5
This result is for Windows 11, as I didn't test it on other platforms.
