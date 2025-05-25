import { App, Gtk, Gdk } from "astal/gtk3"

export default function OpenRightPanel(monitorID: number) {
  return <button
    className="rightpanel"
    cursor="pointer"
    tooltipText={"Show/Hide right panel"}
    valign={Gtk.Align.CENTER}
    halign={Gtk.Align.CENTER}
    onClickRelease={(_, event) => {
      const panel = App.get_window(`RightPanel-${monitorID}`);
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
    <label label="󱗼" css={`font-size: 130%; `} />
  </button>
}
