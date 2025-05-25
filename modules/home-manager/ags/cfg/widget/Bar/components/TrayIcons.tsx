import Tray from "gi://AstalTray"
import { bind } from "astal"

export default function TrayIcons() {
  const tray = Tray.get_default()
  return <box className="tray-icons">
    {bind(tray, "items").as(items => items.map(item => (
      <menubutton
        tooltipMarkup={bind(item, "tooltipMarkup")}
        usePopover={false}
        actionGroup={bind(item, "actionGroup").as(ag => ["dbusmenu", ag])}
        menuModel={bind(item, "menuModel")}>
        <icon gicon={bind(item, "gicon")} />
      </menubutton>
    )))}
  </box>
}
