import { Gtk, Gdk } from "astal/gtk3"
import { Variable, bind } from "astal"
// import Niri from "gi://AstalNiri" // FIXME

// TODO: waiting for https://github.com/Aylur/astal/pull/70
export default function NiriWorkspaces(monitorID: number) {
  return Array.from({ length: 9 }, (_, i) => i + 1).map((btn) =>
    <button
      cursor="pointer"
      valign={Gtk.Align.CENTER}
      halign={Gtk.Align.CENTER}
      setup={(self) => self.toggleClassName("empty")} >
      <label label={`${btn}`} />
    </button>
  )
}
