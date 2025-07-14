import Gtk from "gi://Gtk?version=4.0"
import Gdk from "gi://Gdk?version=4.0"
import { createBinding } from "ags"
import Bluetooth from "gi://AstalBluetooth"

export default function BluetoothStatus() {
  const bluetooth = Bluetooth.get_default();
  return <menubutton
    class="bluetooth"
    cursor={Gdk.Cursor.new_from_name('pointer', null)}
    tooltipText={createBinding(bluetooth, "adapter").as(adapter => `Device name: ${adapter.name}`)}
    valign={Gtk.Align.FILL}
    halign={Gtk.Align.FILL}
    visible={createBinding(bluetooth, "isPowered")} >
    <box
      orientation={Gtk.Orientation.HORIZONTAL}
      valign={Gtk.Align.FILL}
      halign={Gtk.Align.FILL}
      spacing={10}>
      <image class="logo"
        pixelSize={14}
        valign={Gtk.Align.CENTER}
        halign={Gtk.Align.CENTER}
        iconName={createBinding(bluetooth, "isConnected").as(s => s ? "bluetooth-active-symbolic" : "bluetooth-disabled-symbolic")}
      />
      <Gtk.Separator visible />
      <label class="text"
        valign={Gtk.Align.FILL}
        halign={Gtk.Align.FILL}
        label={createBinding(bluetooth, "devices").as(devices => devices[0].connected ? devices[0].name : "N/A")} />
    </box>
    <popover>
      <label label={createBinding(bluetooth, "devices").as(devices => devices[0].connected ? devices[0].name : "N/A")} />
    </popover>
  </menubutton>
}
