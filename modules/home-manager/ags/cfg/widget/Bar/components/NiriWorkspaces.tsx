import Gtk from "gi://Gtk?version=4.0"
import Gdk from "gi://Gdk?version=4.0"

// TODO: waiting for https://github.com/Aylur/astal/pull/70
export default function NiriWorkspaces(monitorID: number) {
  return Array.from({ length: 9 }, (_, i) => i + 1).map((btn) =>
    <button
      cursor={Gdk.Cursor.new_from_name('pointer', null)}
      valign={Gtk.Align.FILL}
      halign={Gtk.Align.FILL}
      class="empty" >
      <label label={`${btn}`} />
    </button>
  )
}
