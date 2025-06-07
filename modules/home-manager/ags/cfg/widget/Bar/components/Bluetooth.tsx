import { Gtk } from "astal/gtk3"
import { bind } from "astal"
import Bluetooth from "gi://AstalBluetooth"

export default function BluetoothStatus() {
  const bluetooth = Bluetooth.get_default();
  return <button
    className="bluetooth"
    onClickRelease={""}
    cursor="pointer"
    tooltipText={bind(bluetooth, "adapter").as(adapter => `Device name: ${adapter.name}`)}
    valign={Gtk.Align.FILL}
    halign={Gtk.Align.CENTER}
    visible={bind(bluetooth, "isPowered")} >
    <box >
      <icon className="logo" css={`margin-right: 8px;`} icon={bind(bluetooth, "isConnected").as(s => s ? "bluetooth-active-symbolic" : "bluetooth-disabled-symbolic")} />
      <label className="text"
        valign={Gtk.Align.FILL}
        halign={Gtk.Align.FILL}
        truncate={true}
        css={`font-size: 80%;`}
        label={bind(bluetooth, "devices").as(devices => devices[0].connected ? devices[0].name : "Not connected")} />
    </box>
  </button>
}
