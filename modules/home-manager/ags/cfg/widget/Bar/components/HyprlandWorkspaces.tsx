import Gtk from "gi://Gtk?version=4.0"
import Gdk from "gi://Gdk?version=4.0"
import { createBinding, createComputed } from "ags"
import Hyprland from "gi://AstalHyprland"

export default function HyprlandWorkspaces(monitorID: number) {
  const hyprland = Hyprland.get_default()
  const ws_state = createComputed([
    createBinding(hyprland, "focusedWorkspace"),
    createBinding(hyprland, "focusedClient"),
    createBinding(hyprland, "workspaces"),
    createBinding(hyprland, "clients")
  ], (fw, fc, wss, cs) => wss.map(ws => ({
    data: ws,
    clients: cs,
    focused: ws.id < 0 ?
      fc && fc?.workspace.id === ws.id :
      fw.id === ws.id,
  }))
  )
  return Array.from({ length: 9 }, (_, i) => i + 1).map((btn) =>
    createBinding(ws_state).as(wss =>
      <button
        cursor={Gdk.Cursor.new_from_name('pointer', null)}
        valign={Gtk.Align.CENTER}
        halign={Gtk.Align.CENTER}
        $={(self) => {
          wss.some(ws => btn + monitorID * 10 == ws.data.id && ws.focused) ? self.toggleClass("focused")
            : wss.some(ws => btn + monitorID * 10 == ws.data.id && ws.clients?.some(c => c.workspace.id == ws.data.id)) ? self.toggleClass("occupied")
              : self.toggleClass("empty")
        }}
        onClicked={(_: any, event) => {
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
