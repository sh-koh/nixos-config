import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind } from "astal"
import Hyprland from "gi://AstalHyprland"


const time = Variable("").poll(1000, `date "+%H\n··\n%M"`)
const date = Variable("").poll(1000, `date "+%d\n\n%m"`)
const fullDate = Variable("").poll(1000, `date "+%A %d %B"`)

function Workspaces(monitorID: number) {
  const hyprland = Hyprland.get_default()
  const ws_state = Variable.derive([
    bind(hyprland, "focusedWorkspace"),
    bind(hyprland, "focusedClient"),
    bind(hyprland, "workspaces")
  ], (fw, fc, wss) =>
    wss.map(ws => ({
      data: ws,
      focused: ws.id < 0 ?
        fc && fc?.workspace.id === ws.id :
        fw.id === ws.id,
    })))
  return <box
    className="workspaces-box"
    vertical={true}
    halign={Gtk.Align.CENTER} >
    {bind(ws_state).as(wss => wss
      .filter(_wss => _wss.data.monitor.id == monitorID)
      .sort((a, b) => a.data.id - b.data.id)
      .map(ws =>
        <button
          className={"workspace"}
          onClick={(_: any, event: Gdk.Event) => {
            switch (event.button) {
              case Gdk.BUTTON_PRIMARY:
                hyprland.message(`dispatch split:workspace ${ws.data.id}`);
                break;
              case Gdk.BUTTON_SECONDARY:
                hyprland.message(`dispatch split:movetoworkspacesilent ${ws.data.id}`);
                break;
              default:
                break;
            }
          }}
          setup={(self) => self.toggleClassName("focused", ws.focused)} >
          {ws.data.id - monitorID * 10}
        </button>
      )
    )}
  </box >
}

export default function Bar(gdkmonitor: Gtk.GdkWaylandMonitor, monitorID: number) {
  return <window
    name={`Bar-${monitorID}`}
    className="Bar"
    monitor={monitorID}
    gdkmonitor={gdkmonitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.BOTTOM}
    application={App}>
    <centerbox vertical={true}>
      <button
        onClicked={""}
        cursor="pointer"
        valign={Gtk.Align.START} >
        <label label={time()} />
      </button>
      {Workspaces(monitorID)}
      <button
        onClicked={""}
        cursor={"pointer"}
        tooltipText={fullDate()}
        valign={Gtk.Align.END} >
        <label label={date()} />
      </button>
    </centerbox>
  </window >
}
