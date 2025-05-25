import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import BatteryStatus from "./components/Battery"
import BluetoothStatus from "./components/Bluetooth"
import MicrophoneStatus from "./components/Microphone"
import MusicStatus from "./components/Mpris"
import NetworkStatus from "./components/Network"
import OpenLeftPanel from "./components/LeftPanelButton"
import OpenRightPanel from "./components/RightPanelButton"
import SpeakerStatus from "./components/Speaker"
import Time from "./components/Time"
import TrayIcons from "./components/TrayIcons"
import Workspaces from "./components/Workspaces"

export default function Bar(gdkmonitor: Gdk.Monitor, monitorID: number) {
  return <window
    name={`Bar - ${monitorID} `}
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
        {OpenLeftPanel(monitorID)}
        <SpeakerStatus />
        <MicrophoneStatus />
        <MusicStatus />
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
        <TrayIcons />
        <BluetoothStatus />
        <NetworkStatus />
        <BatteryStatus />
        <Time />
        {OpenRightPanel(monitorID)}
      </box>
    </centerbox>
  </window>
}
