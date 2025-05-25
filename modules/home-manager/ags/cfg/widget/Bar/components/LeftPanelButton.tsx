import { App, Gtk, Gdk } from "astal/gtk3"

export default function OpenLeftPanel(monitorID: number) {
  return <button
    className="leftpanel"
    cursor="pointer"
    tooltipText={"Show/Hide left panel"}
    valign={Gtk.Align.FILL}
    halign={Gtk.Align.START}
    onClickRelease={(_, event) => {
      const panel = App.get_window(`LeftPanel-${monitorID}`);
      switch (event.button) {
        case Gdk.BUTTON_PRIMARY:
          if (panel != null) panel.visible = !panel.visible
          break;
        case Gdk.BUTTON_SECONDARY:
          break;
        default:
          break;
      }
    }} >
    <box
      vertical={false}
      valign={Gtk.Align.FILL}
      halign={Gtk.Align.START}
      spacing={10} >
      <label
        className="logo"
        valign={Gtk.Align.CENTER}
        halign={Gtk.Align.CENTER}
        label="" css={`font-size: 170%;`} />
      <label
        className="text"
        valign={Gtk.Align.FILL}
        halign={Gtk.Align.FILL}
        label="Start" css={`font-size: 80%;`} />
    </box>
  </button >
}
