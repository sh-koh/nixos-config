import Gdk from "gi://Gdk?version=4.0"
import GLib from "gi://GLib"
import Gtk from "gi://Gtk?version=4.0"
import app from "ags/gtk4/app"
import style from "./style.scss"
import Bar from "./widget/Bar/Bar"
import RightPanel from "./widget/RightPanel/RightPanel"
import AppLauncher from "./widget/AppLauncher/AppLauncher"

let applauncher: Gtk.Window

app.start({
  css: style,
  gtkTheme: "adw-gtk3",
  requestHandler(request, res) {
    const [, argv] = GLib.shell_parse_argv(request)
    if (!argv) return res("argv parse error")

    switch (argv[0]) {
      case "toggle":
        applauncher.visible = !applauncher.visible
        return res("ok")
      default:
        return res("unknown command")
    }
  },
  main() {
    applauncher = AppLauncher() as Gtk.Window
    app.add_window(applauncher)
    applauncher.present()
    app.get_monitors().forEach((gdk: Gdk.Monitor, id: number) => {
      Bar(gdk, id)
      RightPanel(id)
    })
  },
})
