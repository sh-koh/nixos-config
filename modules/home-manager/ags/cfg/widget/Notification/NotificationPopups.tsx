import app from "ags/gtk4/app"
import Gtk from "gi://Gtk?version=4.0"
import Gdk from "gi://Gdk?version=4.0"
import { Astal } from "ags/gtk4"
import Notifd from "gi://AstalNotifd"
import Notification from "./Notification"
import { For, createState } from "ags"

export default function NotificationPopups(gdkmonitor: Gdk.Monitor) {
  const notifd = Notifd.get_default()

  const [notifications, setNotifications] = createState(
    new Array<Notifd.Notification>(),
  )

  const notifiedHandler = notifd.connect("notified", (_, id, replaced) => {
    const notification = notifd.get_notification(id)

    if (replaced && notifications.get().some(n => n.id === id)) {
      setNotifications((ns) => ns.map((n) => (n.id === id ? notification : n)))
    } else {
      setNotifications((ns) => [notification, ...ns])
    }
  })

  const resolvedHandler = notifd.connect("resolved", (_, id) => {
    setNotifications((ns) => ns.filter((n) => n.id !== id))
  })

  return <window
    class="NotificationPopups"
    gdkmonitor={gdkmonitor}
    visible={notifications((ns) => ns.length > 0)}
    anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
  >
    <box orientation={Gtk.Orientation.VERTICAL}>
      <For each={notifications}>
        {(notification) => (
          <Notification
            notification={notification}
            onHoverLost={() =>
              setNotifications((ns) =>
                ns.filter((n) => n.id !== notification.id),
              )
            }
          />
        )}
      </For>
    </box>
  </window>
}
