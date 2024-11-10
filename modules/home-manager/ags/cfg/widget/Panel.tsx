import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind } from "astal"
import Wp from "gi://AstalWp"

export default function Panel(monitorID: number) {
  return <window
    name={`Panel-${monitorID}`}
    visible={false}
    className="Panel"
    monitor={monitorID}
    exclusivity={Astal.Exclusivity.NORMAL}
    anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT | Astal.WindowAnchor.BOTTOM}
    application={App}>
    <box vertical={true} spacing={6}>
      <box className="Panel start" vertical={false} valign={Gtk.Align.START} halign={Gtk.Align.CENTER} >
        {"peut être ?"}
        <box className="Panel start" vertical={false} valign={Gtk.Align.START} halign={Gtk.Align.CENTER} >
          {"peut être ?"}
        </box>
        <box className="Panel start" vertical={false} valign={Gtk.Align.START} halign={Gtk.Align.CENTER} >
          {"peut être ?"}
        </box>
        <box className="Panel start" vertical={false} valign={Gtk.Align.START} halign={Gtk.Align.CENTER} >
          {"peut être ?"}
        </box>
        <box className="Panel start" vertical={false} valign={Gtk.Align.START} halign={Gtk.Align.CENTER} >
          {"peut être ?"}
        </box>
      </box>
      <box className="Panel middle" vertical={false} valign={Gtk.Align.CENTER} halign={Gtk.Align.CENTER} >
        {"ah?!"}
      </box>
      <box className="Panel middle" vertical={false} valign={Gtk.Align.CENTER} halign={Gtk.Align.CENTER} >
        {"ah?!"}
      </box>
      <box className="Panel middle" vertical={false} valign={Gtk.Align.CENTER} halign={Gtk.Align.CENTER} >
        {"ah?!"}
      </box>
      <box className="Panel end" vertical={true} valign={Gtk.Align.FILL} halign={Gtk.Align.FILL} hexpand={true} vexpand={true} >
        <slider />
        <levelbar />
        <entry />
        <stack />
        <switch />
      </box>
    </box >
  </window >
}
