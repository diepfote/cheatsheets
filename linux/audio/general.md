# Audio (I assume you use pipewire)

## aplay

Check all available hardware devices

```
aplay -l
```

Play sound to figure out which one it is:

```
#  (Internal audio = id: 0)
while read -r i; do echo "$i"; aplay -D plughw:0,"$i" /usr/share/sounds/alsa/Front_Right.wav; done < <(seq 0 10)
```

**Hint**: For HDMI devices make sure the display is already used (visually).  
e.g.  
`xrandr --output HDMI2 --same-as eDP1 --auto`

## pavucontrol

Check available audio devices (based on card-profile --> available to
applications)

## amixer

Get device volume via cli.

## alsamixer

Change Playback and Capture settings (Master vol, Devices, PCM, ...) 

## pactl

### list cards (profiles is where it's at)

```
pactl list cards
```

```
# not useful if you need anything other than the card name or numeric id
pactl list cards short
```

### set-card-profile | set card profile | bad audio

```
# change audio profile for bluetooth device
# to improve audio quality
pactl set-card-profile bluez_card.<hardware-address> a2dp-sink

# reset to default
#
pactl set-card-profile alsa_card.pci-0000_00_1f.3  output:analog-stereo+input:analog-stereo

# hdmi out (TV audio)
pactl set-card-profile alsa_card.pci-0000_00_1f.3  output:hdmi-stereo-extra1
```

**Hint**: 
If the default profile (analog in/out; thinkpad laptop) profile
is not displayed [reinitalize](#reinitalize-card-driver-to-default-state)
the internal audio card  (thinkpad laptop).

**Hint**:
Find audio card profile via `aplay -D ...`, after listing all devices via `aplay -l`.  
Check for device name in `pactl list cards` output.
Use one of the profiles displayed in the "Part of profile..." 
section in the output of `pactl list cards` for this device.


## get default output device

```
pactl get-default-sink
```

## reinitalize card driver to default state

```
alsactl init <card-id-number>

# for internal card
alsactl init 0
```
