import Gtk from "gi://Gtk?version=4.0"
import Gdk from "gi://Gdk?version=4.0"
import { createBinding } from "ags"
import Battery from "gi://AstalBattery"

export default function BatteryStatus() {
  const bat = Battery.get_default();
  return <menubutton
    class={createBinding(bat, "percentage").as(p => p > 0.2 ? "battery low" : "battery")}
    cursor={Gdk.Cursor.new_from_name('pointer', null)}
    valign={Gtk.Align.FILL}
    halign={Gtk.Align.FILL}
    visible={createBinding(bat, "isPresent")} >
    <box
      orientation={Gtk.Orientation.HORIZONTAL}
      valign={Gtk.Align.FILL}
      halign={Gtk.Align.FILL}
      spacing={10} >
      <image
        class="logo"
        pixelSize={14}
        valign={Gtk.Align.CENTER}
        halign={Gtk.Align.CENTER}
        iconName={createBinding(bat, "batteryIconName")} />
      <Gtk.Separator visible />
      <label
        class="text"
        valign={Gtk.Align.FILL}
        halign={Gtk.Align.FILL}
        label={createBinding(bat, "percentage").as(p => `${Math.floor(p * 100)}%`)} />
    </box>
    <popover>
    </popover>
  </menubutton >
}
