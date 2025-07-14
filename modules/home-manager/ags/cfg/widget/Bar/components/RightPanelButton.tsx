import app from "ags/gtk4/app"
import Gtk from "gi://Gtk?version=4.0"
import Gdk from "gi://Gdk?version=4.0"

export default function RightPanelButton(monitorID: number) {
  return <button
    class="rightpanel"
    cursor={Gdk.Cursor.POINTER}
    tooltipText={"Show/Hide right panel"}
    valign={Gtk.Align.FILL}
    halign={Gtk.Align.END}
    onClicked={() => {
      const panel = app.get_window(`RightPanel-${monitorID}`);
      if (panel != null) panel.visible = !panel.visible
    }} >
    <image
      valign={Gtk.Align.CENTER}
      halign={Gtk.Align.CENTER}
      iconName="orientation-portrait-inverse-symbolic"
    />
  </button >
}
