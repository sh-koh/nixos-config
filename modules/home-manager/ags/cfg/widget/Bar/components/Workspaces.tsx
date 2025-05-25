import { Gtk, Gdk } from "astal/gtk3"
import { Variable, bind } from "astal"
import Hyprland from "gi://AstalHyprland"

export default function Workspaces(monitorID: number) {
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
