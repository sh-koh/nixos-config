import { Gtk } from "astal/gtk3"
import { bind } from "astal"
import Battery from "gi://AstalBattery"

export default function BatteryStatus() {
  const bat = Battery.get_default();
  return <button
    className="battery"
    onClickRelease={""}
    cursor="pointer"
    valign={Gtk.Align.FILL}
    halign={Gtk.Align.CENTER}
    visible={bind(bat, "isPresent")} >
    <box
      vertical={false}
      valign={Gtk.Align.FILL}
      halign={Gtk.Align.START}
      spacing={10} >
      <icon className="logo" css={`margin-right: 8px;`} icon={bind(bat, "batteryIconName")} />
      <label className="text"
        valign={Gtk.Align.FILL}
        halign={Gtk.Align.FILL}
        truncate={true}
        css={`font-size: 80%;`}
        label={bind(bat, "percentage").as(p => `${Math.floor(p * 100)}%`)} />
    </box>
  </button >
}
