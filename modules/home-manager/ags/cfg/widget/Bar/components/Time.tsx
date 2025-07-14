import Gtk from "gi://Gtk?version=4.0"
import Gdk from "gi://Gdk?version=4.0"
import GLib from "gi://GLib"
import { createPoll } from "ags/time"

export default function Time() {
  const date = (fmt: string) => createPoll("", 1000, () => {
    return GLib.DateTime.new_now_local().format(fmt)!
  })
  return <menubutton
    class="time"
    cursor={Gdk.Cursor.new_from_name('pointer', null)}
    tooltipText={date("%a %d %B %Y")}
    valign={Gtk.Align.FILL}
    halign={Gtk.Align.FILL} >
    <box
      orientation={Gtk.Orientation.HORIZONTAL}
      valign={Gtk.Align.FILL}
      halign={Gtk.Align.FILL}
      spacing={10} >
      <image
        class="logo"
        valign={Gtk.Align.CENTER}
        halign={Gtk.Align.CENTER}
        iconName="preferences-system-time-symbolic" />
      <Gtk.Separator visible />
      <label
        class="text"
        valign={Gtk.Align.FILL}
        halign={Gtk.Align.FILL}
        label={date("%H:%M")} />
    </box>
    <popover>
      <Gtk.Calendar />
    </popover>
  </menubutton >
}
