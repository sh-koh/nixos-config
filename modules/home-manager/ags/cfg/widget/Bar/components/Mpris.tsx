import { Gtk, Gdk } from "astal/gtk3"
import { bind } from "astal"
import Mpris from "gi://AstalMpris"

export default function MusicStatus() {
  const mpris = Mpris.get_default();
  return bind(mpris, "players").as(ps => ps[0] ? (
    <button
      className="music"
      onClickRelease={(_: any, event) => {
        switch (event.button) {
          case Gdk.BUTTON_PRIMARY:
            ps[0].play_pause();
            break;
          case Gdk.BUTTON_SECONDARY:
            ps[0].next()
            break;
          default:
            break;
        }
      }}
      cursor="pointer"
      tooltipText={bind(ps[0], "metadata").as(() => `${ps[0].artist} - ${ps[0].title}`)}
      valign={Gtk.Align.CENTER}
      halign={Gtk.Align.CENTER} >
      <box
        vertical={false}
        valign={Gtk.Align.CENTER}
        halign={Gtk.Align.START}
        spacing={10} >
        <label className="logo"
          valign={Gtk.Align.CENTER}
          halign={Gtk.Align.CENTER}
          css={`font-size: 170%;`}
          label="♫" />
        <label className="text"
          valign={Gtk.Align.FILL}
          halign={Gtk.Align.FILL}
          truncate={true}
          maxWidthChars={24}
          css={`font-size: 80%;`}
          label={bind(ps[0], "metadata").as(() => `${ps[0].artist} - ${ps[0].title}`)} />
      </box>
    </button>
  ) : (
    <button
      className="music"
      cursor="pointer"
      tooltipText={`Nothing is playing...`}
      visible={false}
      valign={Gtk.Align.CENTER}
      halign={Gtk.Align.CENTER} >
      <box
        vertical={false}
        valign={Gtk.Align.CENTER}
        halign={Gtk.Align.START}
        spacing={10} >
        <label className="logo"
          valign={Gtk.Align.CENTER}
          halign={Gtk.Align.CENTER}
          css={`font-size: 170%;`}
          label="♫" />
        <label className="text"
          valign={Gtk.Align.FILL}
          halign={Gtk.Align.FILL}
          truncate={true}
          maxWidthChars={24}
          css={`font-size: 80%;`}
          label={`Nothing is playing...`} />
      </box>
    </button>
  ))
}
