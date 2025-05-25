import { Gtk } from "astal/gtk3"
import { Variable, bind } from "astal"
import Network from "gi://AstalNetwork"

export default function NetworkStatus() {
  const net = Network.get_default();
  const wifi = bind(net, "wifi");
  const wired = bind(net, "wired");
  const internet_type = bind(net, "primary");
  const internet_icon = Variable.derive([internet_type, wifi, wired], (type: Network.Primary, wifi: Network.Wifi, wired: Network.Wired) => {
    switch (type) {
      case Network.Primary.WIFI: return wifi.iconName;
      case Network.Primary.WIRED: return wired.iconName;
      case Network.Primary.UNKNOWN: return "network-wireless-offline-symbolic"
    }
  });
  const internet_name = Variable.derive([internet_type, wifi], (internet_type: Network.Primary, wifi: Network.Wifi) => {
    switch (internet_type) {
      case Network.Primary.WIFI: return wifi.ssid;
      case Network.Primary.WIRED: return "Ethernet";
      case Network.Primary.UNKNOWN: return "Disconnected";
    }
  });
  return <button
    className={"networking"}
    onClickRelease={""}
    cursor={"pointer"}
    valign={Gtk.Align.FILL}
    halign={Gtk.Align.CENTER} >
    <box
      vertical={false}
      valign={Gtk.Align.FILL}
      halign={Gtk.Align.START}
      spacing={10} >
      <icon className="logo" icon={internet_icon()} />
      <label className="text"
        valign={Gtk.Align.FILL}
        halign={Gtk.Align.FILL}
        truncate={true}
        maxWidthChars={24}
        css={`font-size: 80%;`}
        label={internet_name()} />
    </box>
  </button >
}
