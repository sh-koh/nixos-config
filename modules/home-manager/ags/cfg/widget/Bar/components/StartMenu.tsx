import Gtk from "gi://Gtk?version=4.0"
import Gdk from "gi://Gdk?version=4.0"

export default function StartMenu(monitorID: number) {
  return <menubutton
    class="leftpanel"
    cursor={Gdk.Cursor.new_from_name('pointer', null)}
    tooltipText={"Show/Hide left panel"}
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
        iconName="nix-snowflake" />
      <Gtk.Separator visible />
      <label
        class="text"
        valign={Gtk.Align.FILL}
        halign={Gtk.Align.FILL}
        label="Start" />
    </box>
    <popover>
      <label
        valign={Gtk.Align.FILL}
        halign={Gtk.Align.FILL}
        label="TODO" />
    </popover>
  </menubutton >
}
