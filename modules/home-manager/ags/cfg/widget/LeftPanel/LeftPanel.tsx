import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind } from "astal"

export default function LeftPanel(monitorID: number) {
  return <window
    name={`LeftPanel-${monitorID}`}
    visible={false}
    className="LeftPanel"
    monitor={monitorID}
    exclusivity={Astal.Exclusivity.NORMAL}
    anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.BOTTOM}
    application={App}>
    <box vertical={true} valign={Gtk.Align.FILL} halign={Gtk.Align.CENTER} hexpand={true} vexpand={true} spacing={6}>
      <box className="Panel start" vertical={true} valign={Gtk.Align.START} halign={Gtk.Align.FILL} hexpand={true} vexpand={true}>
        <slider />
        <levelbar />
      </box>
      <box className="Panel middle" vertical={true} valign={Gtk.Align.FILL} halign={Gtk.Align.FILL} hexpand={true} vexpand={true}>
        <entry />
        <stack />
        <switch />
      </box>
      <box className="Panel end" vertical={true} valign={Gtk.Align.END} halign={Gtk.Align.FILL} hexpand={true} vexpand={true} >
        <menubutton></menubutton>
      </box>
    </box >
  </window >
}
