import { App } from "astal/gtk3"
import style from "./style.scss"
import Bar from "./widget/Bar/Bar"
import LeftPanel from "./widget/LeftPanel/LeftPanel"
import RightPanel from "./widget/RightPanel/RightPanel"
import NotificationPopups from "./widget/Notification/NotificationPopups"

App.start({
  css: style,
  main() {
    App.get_monitors().forEach((v, i) => {
      Bar(v, i)
      RightPanel(i)
      LeftPanel(i)
      NotificationPopups(v)
    })
  },
})
