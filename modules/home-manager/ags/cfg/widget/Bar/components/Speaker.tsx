import { Astal, Gtk, Gdk } from "astal/gtk3"
import { bind } from "astal"
import Wp from "gi://AstalWp"

let speaker_vol = 0.5;
export default function SpeakerStatus(): Astal.Button {
  const audio = Wp.get_default();
  if (!audio) return <></>
  const default_speaker = audio?.defaultSpeaker;
  const volume = bind(default_speaker, "volume").as(v => Math.ceil(v * 100));
  return <button
    className="audio-speaker"
    onClickRelease={(_, event) => {
      if (default_speaker.volume != 0) speaker_vol = default_speaker.volume;
      switch (event.button) {
        case Gdk.BUTTON_PRIMARY: default_speaker.volume == 0 ? default_speaker.volume = speaker_vol : default_speaker.volume = 0;
      }
    }}
    onScroll={(_, event) => {
      event.delta_y > 0
        ? default_speaker.volume = default_speaker.volume - 0.05
        : default_speaker.volume + 0.05 > 1 ? default_speaker.volume = 1 : default_speaker.volume = default_speaker.volume + 0.05;
    }}
    cursor="pointer"
    tooltipText={bind(default_speaker, "description")}
    valign={Gtk.Align.FILL}
    halign={Gtk.Align.CENTER} >
    <box
      vertical={false}
      valign={Gtk.Align.FILL}
      halign={Gtk.Align.START}
      spacing={10} >
      <icon className="logo" icon={bind(default_speaker, "volumeIcon")} />
      <label className="text"
        valign={Gtk.Align.FILL}
        halign={Gtk.Align.FILL}
        truncate={true}
        css={`font-size: 80%;`}
        label={volume.as(v => `${v}%`)} />
    </box>
  </button>
}
