import { Gtk, Gdk } from "astal/gtk3"
import { bind } from "astal"
import Wp from "gi://AstalWp"

let mic_vol = 1;
export default function MicrophoneStatus() {
  const audio = Wp.get_default();
  if (!audio) return <></>
  const default_microphone = audio?.defaultMicrophone;
  const volume = bind(default_microphone, "volume").as(v => Math.ceil(v * 100));
  return <button
    className="audio-microphone"
    onClickRelease={(_, event) => {
      if (default_microphone.volume != 0) mic_vol = default_microphone.volume;
      switch (event.button) {
        case Gdk.BUTTON_PRIMARY: default_microphone.volume == 0 ? default_microphone.volume = mic_vol : default_microphone.volume = 0;
      }
    }}
    onScroll={(_, event) => {
      event.delta_y > 0
        ? default_microphone.volume = default_microphone.volume - 0.05
        : default_microphone.volume + 0.05 > 1
          ? default_microphone.volume = 1
          : default_microphone.volume = default_microphone.volume + 0.05;
    }}
    cursor="pointer"
    tooltipText={bind(default_microphone, "description")}
    valign={Gtk.Align.FILL}
    halign={Gtk.Align.CENTER} >
    <box
      vertical={false}
      valign={Gtk.Align.FILL}
      halign={Gtk.Align.START}
      spacing={10} >
      <icon className="logo" icon={bind(default_microphone, "volumeIcon")} />
      <label className="text"
        valign={Gtk.Align.FILL}
        halign={Gtk.Align.FILL}
        truncate={true}
        css={`font-size: 80%;`}
        label={volume.as(v => `${v}%`)} />
    </box>
  </button >
}
