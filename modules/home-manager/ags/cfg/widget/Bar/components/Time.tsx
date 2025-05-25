import { Gtk } from "astal/gtk3"
import { Variable, bind } from "astal"

export default function Time() {
  const time = Variable("").poll(1000, `date "+%H:%M"`);
  const fullDate = Variable("").poll(1000, `date "+%a %d %B %Y"`);
  return <button
    className="time"
    onClickRelease={""}
    cursor="pointer"
    tooltipText={fullDate()}
    valign={Gtk.Align.FILL}
    halign={Gtk.Align.CENTER} >
    <box
      vertical={false}
      valign={Gtk.Align.FILL}
      halign={Gtk.Align.START}
      spacing={10} >
      <label
        className="logo"
        valign={Gtk.Align.CENTER}
        halign={Gtk.Align.CENTER}
        label="" css={`font-size: 140%;`} />
      <label
        className="text"
        valign={Gtk.Align.FILL}
        halign={Gtk.Align.FILL}
        label={time()} css={`font-size: 80%;`} />
    </box>
  </button>
}
