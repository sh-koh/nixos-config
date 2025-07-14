import app from "ags/gtk4/app"
import { Astal } from "ags/gtk4"
import Gtk from "gi://Gtk?version=4.0"
import Gdk from "gi://Gdk?version=4.0"
import { createBinding } from "ags"
import Wp from "gi://AstalWp"

export default function RightPanel(monitorID: number) {
  return <window
    name={`RightPanel-${monitorID}`}
    visible={false}
    class="RightPanel"
    monitor={monitorID}
    exclusivity={Astal.Exclusivity.NORMAL}
    anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT | Astal.WindowAnchor.BOTTOM}
    application={app}>
    <box orientation={Gtk.Orientation.VERTICAL} valign={Gtk.Align.FILL} halign={Gtk.Align.CENTER} hexpand vexpand={true} spacing={6}>
      <box class="Panel start" orientation={Gtk.Orientation.VERTICAL} valign={Gtk.Align.START} halign={Gtk.Align.FILL} hexpand vexpand={true}>
        <slider />
        <levelbar />
      </box>
      <box class="Panel middle" orientation={Gtk.Orientation.VERTICAL} valign={Gtk.Align.FILL} halign={Gtk.Align.FILL} hexpand vexpand={true}>
        <entry />
        <stack />
        <switch />
      </box>
      <box class="Panel end" orientation={Gtk.Orientation.VERTICAL} valign={Gtk.Align.END} halign={Gtk.Align.FILL} hexpand vexpand={true} >
      </box>
    </box >
  </window >
}
