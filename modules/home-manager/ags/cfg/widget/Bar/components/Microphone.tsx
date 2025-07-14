import Gtk from "gi://Gtk?version=4.0"
import Gdk from "gi://Gdk?version=4.0"
import { createBinding } from "ags"
import Wp from "gi://AstalWp"

export default function MicrophoneStatus() {
  const audio = Wp.get_default();
  if (!audio) return <></>
  const default_microphone = audio?.defaultMicrophone;
  const volume = createBinding(default_microphone, "volume");
  return <menubutton
    class="audio-microphone"
    cursor={Gdk.Cursor.new_from_name('pointer', null)}
    tooltipText={createBinding(default_microphone, "description")}
    valign={Gtk.Align.FILL}
    halign={Gtk.Align.FILL} >
    <box
      orientation={Gtk.Orientation.HORIZONTAL}
      valign={Gtk.Align.FILL}
      halign={Gtk.Align.FILL}
      spacing={10} >
      <image
        class="logo"
        iconName={createBinding(default_microphone, "volumeIcon")}
        valign={Gtk.Align.CENTER}
        halign={Gtk.Align.CENTER}
        pixelSize={14} />
      <Gtk.Separator visible />
      <label
        class="text"
        valign={Gtk.Align.FILL}
        halign={Gtk.Align.FILL}
        label={volume.as(v => `${Math.ceil(v * 100)}%`)}
      />
    </box>
    <popover>
      <slider
        widthRequest={220}
        value={volume}
        onChangeValue={({ value }) => default_microphone.set_volume(value)}
      />
    </popover>
  </menubutton >
}
