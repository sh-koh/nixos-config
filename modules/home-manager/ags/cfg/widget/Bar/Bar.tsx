import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind } from "astal"
import Hyprland from "gi://AstalHyprland"
import Battery from "gi://AstalBattery"
import Bluetooth from "gi://AstalBluetooth"
import Mpris from "gi://AstalMpris"
import Network from "gi://AstalNetwork"
import Wp from "gi://AstalWp"


function Workspaces(monitorID: number) {
  const hyprland = Hyprland.get_default()
  const ws_state = Variable.derive([
    bind(hyprland, "focusedWorkspace"),
    bind(hyprland, "focusedClient"),
    bind(hyprland, "workspaces"),
    bind(hyprland, "clients")
  ], (fw, fc, wss, cs) => wss.map(ws => ({
    data: ws,
    clients: cs,
    focused: ws.id < 0 ?
      fc && fc?.workspace.id === ws.id :
      fw.id === ws.id,
  }))
  )
  return Array.from({ length: 9 }, (_, i) => i + 1).map((btn) =>
    bind(ws_state).as(wss =>
      <button
        cursor="pointer"
        valign={Gtk.Align.CENTER}
        halign={Gtk.Align.CENTER}
        setup={(self) => {
          wss.some(ws => btn + monitorID * 10 == ws.data.id && ws.focused) ? self.toggleClassName("focused")
            : wss.some(ws => btn + monitorID * 10 == ws.data.id && ws.clients?.some(c => c.workspace.id == ws.data.id)) ? self.toggleClassName("occupied")
              : self.toggleClassName("empty")
        }}
        onClickRelease={(_: any, event) => {
          switch (event.button) {
            case Gdk.BUTTON_PRIMARY:
              hyprland.message(`dispatch split:workspace ${btn + monitorID * 10}`);
              break;
            case Gdk.BUTTON_SECONDARY:
              hyprland.message(`dispatch split:movetoworkspace ${btn + monitorID * 10}`);
              break;
            case Gdk.BUTTON_MIDDLE:
              hyprland.message(`dispatch split:movetoworkspacesilent ${btn + monitorID * 10}`);
              break;
            default:
              break;
          }
        }} >
        <label label={`${btn}`} />
      </button>
    )
  )
}

function BatteryStatus() {
  const bat = Battery.get_default();
  return <button
    className="battery"
    onClicked={""}
    cursor="pointer"
    tooltipText={bind(bat, "percentage").as(p => `${Math.floor(p * 100)}%`)}
    valign={Gtk.Align.CENTER}
    halign={Gtk.Align.CENTER}
    visible={bind(bat, "isPresent")} >
    <icon icon={bind(bat, "batteryIconName")} />
  </button>
}

function BluetoothStatus() {
  const bluetooth = Bluetooth.get_default();
  return <button
    className="bluetooth"
    onClicked={""}
    cursor="pointer"
    tooltipText={"bluetooth icon!"}
    valign={Gtk.Align.CENTER}
    halign={Gtk.Align.CENTER}
    visible={bind(bluetooth, "isPowered")} >
    <box >
      <icon icon={bind(bluetooth, "isConnected").as(s => s ? "bluetooth-active-symbolic" : "bluetooth-disabled-symbolic")} />
    </box>
  </button>
}

// function MusicStatus() {
//   const music = Mpris.get_default();
//   const players = bind(music, "players");
//   return <button
//     className="music"
//     onClicked={""}
//     cursor="pointer"
//     tooltipText={players.as(ps => `${ps[0].title} - ${ps[0].artist}`)}
//     valign={Gtk.Align.CENTER}
//     halign={Gtk.Align.CENTER} >
//     {players.as(ps => <label truncate={true} maxWidthChars={30} label={`${ps[0].title} - ${ps[0].artist}`} />)}
//   </button>
// }

function NetworkStatus() {
  const internet_type_to_icon = (type: Network.Primary, wifi: Network.Wifi, wired: Network.Wired) => {
    switch (type) {
      case Network.Primary.WIFI: return wifi.iconName;
      case Network.Primary.WIRED: return wired.iconName;
      case Network.Primary.UNKNOWN: return "network-wireless-offline-symbolic"
    }
  }
  const network_name = (internet_type: Network.Primary, wifi: Network.Wifi) => {
    switch (internet_type) {
      case Network.Primary.WIFI: return wifi.ssid;
      case Network.Primary.WIRED: return "Ethernet";
      case Network.Primary.UNKNOWN: return "Disconnected";
    }
  }
  const net = Network.get_default();
  const internet_type = bind(net, "primary");
  const wifi = bind(net, "wifi");
  const wired = bind(net, "wired");
  const internet_icon = Variable.derive([internet_type, wifi, wired], (type, wifi, wired) => internet_type_to_icon(type, wifi, wired));
  const internet_name = Variable.derive([internet_type, wifi], (type, wifi) => network_name(type, wifi));
  return <button
    className={"networking"}
    onClicked={""}
    cursor={"pointer"}
    tooltipText={internet_name()}
    valign={Gtk.Align.CENTER}
    halign={Gtk.Align.CENTER} >
    <icon icon={internet_icon()} />
  </button>
}

function AudioStatus() {
  const audio = Wp.get_default();
  if (!audio) return <></>
  const default_speaker = audio?.defaultSpeaker;
  const volume = bind(default_speaker, "volume").as(v => Math.ceil(v * 100));
  return <button
    className="audio"
    onClicked={""}
    cursor="pointer"
    tooltipText={volume.as(String)}
    valign={Gtk.Align.CENTER}
    halign={Gtk.Align.CENTER} >
    <icon icon={bind(default_speaker, "volume_icon")} />
  </button>
}

function Time() {
  const time = Variable("").poll(1000, `date "+%H:%M"`)
  const fullDate = Variable("").poll(1000, `date "+%A %d %B %Y"`)
  return <button
    className="time"
    onClicked={""}
    cursor="pointer"
    tooltipText={fullDate()}
    valign={Gtk.Align.CENTER}
    halign={Gtk.Align.CENTER} >
    <label label={time()} />
  </button>
}

function OpenPanel(monitorID: number) {
  return <button
    className="panel"
    cursor="pointer"
    tooltipText={"Show/Hide right panel."}
    valign={Gtk.Align.CENTER}
    halign={Gtk.Align.CENTER}
    onClickRelease={(self, e) => {
      const panel = App.get_window(`Panel-${monitorID}`)
      const label = self.get_child()
      switch (e.button) {
        case Gdk.BUTTON_PRIMARY:
          if (panel != null) panel.visible = !panel.visible
          break;
        case Gdk.BUTTON_SECONDARY:
          break;
        default:
          break;
      }
    }} >
    <label label="󱗼" css={`font-size: 130%;`} />
  </button>
}

export default function Bar(gdkmonitor: Gdk.Monitor, monitorID: number) {
  return <window
    name={`Bar-${monitorID}`}
    className="Bar"
    monitor={monitorID}
    gdkmonitor={gdkmonitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={Astal.WindowAnchor.LEFT | Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
    application={App}>
    <centerbox vertical={false} >
      <box
        className="Bar start"
        vertical={false}
        valign={Gtk.Align.CENTER}
        halign={Gtk.Align.START} >
      </box>
      <box
        className="Bar middle"
        vertical={false}
        valign={Gtk.Align.CENTER}
        halign={Gtk.Align.CENTER} >
        {Workspaces(monitorID)}
      </box>
      <box
        className="Bar end"
        vertical={false}
        valign={Gtk.Align.CENTER}
        halign={Gtk.Align.END} >
        <AudioStatus />
        <BluetoothStatus />
        <NetworkStatus />
        <BatteryStatus />
        <Time />
        {OpenPanel(monitorID)}
      </box>
    </centerbox>
  </window>
}
