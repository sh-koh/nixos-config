import Gtk from "gi://Gtk?version=4.0"
import Tray from "gi://AstalTray"
import { For, createBinding } from "ags"

export default function TrayIcons() {
  const tray = Tray.get_default()
  const items = createBinding(tray, "items")
  function init(btn: Gtk.MenuButton, item: Tray.TrayItem) {
    btn.menuModel = item.menuModel
    btn.insert_action_group("dbusmenu", item.actionGroup)
    item.connect("notify::action-group", () => {
      btn.insert_action_group("dbusmenu", item.actionGroup)
    })
  }
  return (
    <box
      class="tray-icons"
      orientation={Gtk.Orientation.HORIZONTAL}
      valign={Gtk.Align.FILL}
      halign={Gtk.Align.FILL}
      spacing={10} >
      <For each={items}>
        {(item) => (
          <menubutton $={(self) => init(self, item)}>
            <image gicon={createBinding(item, "gicon")} />
          </menubutton>
        )}
      </For>
    </box>
  )
}
