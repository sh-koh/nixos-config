import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind } from "astal"
import Hyprland from "gi://AstalHyprland"


function OpenPanel(monitorID: number) {
  return <button
    className="panel"
    cursor="pointer"
    valign={Gtk.Align.CENTER}
    halign={Gtk.Align.CENTER}
    onClickRelease={(self, e) => {
      const panel = App.get_window(`Panel-${monitorID}`)
      const label = self.get_child()
      switch (e.button) {
        case Gdk.BUTTON_PRIMARY:
          if (panel != null) {
            panel.visible = !panel.visible
            panel.visible ? label.angle = 180 : label.angle = 0
          }
          break;
        case Gdk.BUTTON_SECONDARY:
          if (panel != null) { panel.visible = !panel.visible }
          break;
        default:
          break;
      }
    }} >
    <label label="" />
  </button>
}

function Workspaces(monitorID: number) {
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

function Time() {
  const time = Variable("").poll(1000, `date "+%H\n%M"`)
  const fullDate = Variable("").poll(1000, `date "+%A %d %B %Y"`)
  return <button
    className="time"
    onClicked={""}
    cursor="pointer"
    tooltipText={fullDate()}
    valign={Gtk.Align.CENTER}
    halign={Gtk.Align.CENTER} >
    <label label={time()} />
  </button>
}

export default function Bar(gdkmonitor: Gtk.GdkWaylandMonitor, monitorID: number) {
  return <window
    name={`Bar-${monitorID}`}
    className="Bar"
    monitor={monitorID}
    gdkmonitor={gdkmonitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT | Astal.WindowAnchor.BOTTOM}
    application={App}>
    <centerbox vertical={true} >
      <box
        className="Bar start"
        vertical={true}
        valign={Gtk.Align.START}
        halign={Gtk.Align.CENTER} >
        {OpenPanel(monitorID)}
      </box>
      <box
        className="Bar middle"
        vertical={true}
        valign={Gtk.Align.CENTER}
        halign={Gtk.Align.CENTER} >
        {Workspaces(monitorID)}
      </box>
      <box
        className="Bar end"
        vertical={true}
        valign={Gtk.Align.END}
        halign={Gtk.Align.CENTER} >
        {Time()}
      </box>
    </centerbox>
  </window>
}
