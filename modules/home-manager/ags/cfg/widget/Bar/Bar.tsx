import app from "ags/gtk4/app"
import { Astal } from "ags/gtk4"
import Gtk from "gi://Gtk?version=4.0"
import Gdk from "gi://Gdk?version=4.0"
import BatteryStatus from "./components/Battery"
import BluetoothStatus from "./components/Bluetooth"
import MicrophoneStatus from "./components/Microphone"
import MusicStatus from "./components/Mpris"
import NetworkStatus from "./components/Network"
import StartMenu from "./components/StartMenu"
import RightPanelButton from "./components/RightPanelButton"
import SpeakerStatus from "./components/Speaker"
import Time from "./components/Time"
import TrayIcons from "./components/Tray"
import Workspaces from "./components/Workspaces"

export default function Bar(gdkmonitor: Gdk.Monitor, monitorID: number) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor
  return <window
    visible
    class="bar"
    gdkmonitor={gdkmonitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={TOP | LEFT | RIGHT}
    application={app}>
    <centerbox orientation={Gtk.Orientation.HORIZONTAL} >
      <box
        class="Bar start"
        orientation={Gtk.Orientation.HORIZONTAL}
        $type="start"
        spacing={3}
        valign={Gtk.Align.FILL}
        halign={Gtk.Align.START} >
        <StartMenu />
        <SpeakerStatus />
        <MicrophoneStatus />
        <MusicStatus />
      </box>
      <box
        class="Bar middle"
        orientation={Gtk.Orientation.HORIZONTAL}
        $type="center"
        spacing={3}
        valign={Gtk.Align.FILL}
        halign={Gtk.Align.CENTER} >
        {Workspaces(monitorID)}
      </box>
      <box
        class="Bar end"
        orientation={Gtk.Orientation.HORIZONTAL}
        $type="end"
        spacing={3}
        valign={Gtk.Align.FILL}
        halign={Gtk.Align.END} >
        <TrayIcons />
        <BluetoothStatus />
        <NetworkStatus />
        <BatteryStatus />
        <Time />
        {RightPanelButton(monitorID)}
      </box>
    </centerbox >
  </window >
}
