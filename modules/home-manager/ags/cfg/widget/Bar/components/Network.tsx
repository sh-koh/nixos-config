import Gtk from "gi://Gtk?version=4.0"
import Gdk from "gi://Gdk?version=4.0"
import { With, createBinding, } from "ags"
import Network from "gi://AstalNetwork"

export default function NetworkStatus() {
  const network = Network.get_default()
  const primary = createBinding(network, "primary")
  return <menubutton
    class="networking"
    cursor={Gdk.Cursor.new_from_name('pointer', null)}
    valign={Gtk.Align.FILL}
    halign={Gtk.Align.FILL} >
    <box
      orientation={Gtk.Orientation.HORIZONTAL}
      valign={Gtk.Align.FILL}
      halign={Gtk.Align.FILL}
      spacing={10} >
      <With value={primary}>
        {value => value === Network.Primary.WIFI ?
          <image
            class="logo"
            pixelSize={14}
            valign={Gtk.Align.CENTER}
            halign={Gtk.Align.CENTER}
            iconName={createBinding(network.wifi, "iconName")} />
          :
          value === Network.Primary.WIRED ? <image
            class="logo"
            pixelSize={14}
            valign={Gtk.Align.CENTER}
            halign={Gtk.Align.CENTER}
            iconName={createBinding(network.wired, "iconName")} />
            :
            <image
              class="logo"
              pixelSize={14}
              valign={Gtk.Align.CENTER}
              halign={Gtk.Align.CENTER}
              iconName={"network-offline-symbolic"} />
        }
      </With>
      <Gtk.Separator visible />
      <label
        class="text"
        valign={Gtk.Align.FILL}
        halign={Gtk.Align.FILL}
        maxWidthChars={24}
        label={primary.ssid || "Ethernet"} />
    </box>
    <popover>
      <label label={primary.ssid || "Ethernet"} />
    </popover>
  </menubutton>
}
