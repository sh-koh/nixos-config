import { For, createState } from "ags"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import Apps from "gi://AstalApps"
import Graphene from "gi://Graphene"

const { TOP, BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor

export default function AppLauncher() {
  let contentbox: Gtk.Box
  let searchentry: Gtk.Entry
  let win: Astal.Window
  const apps = new Apps.Apps()
  const [list, setList] = createState(new Array<Apps.Application>())
  function search(text: string) {
    if (text === "") setList([])
    else setList(apps.fuzzy_query(text).slice(0, 8))
  }
  function launch(app?: Apps.Application) {
    if (app) {
      win.hide()
      app.launch()
    }
  }
  return (
    <window
      $={(ref) => (win = ref)}
      name="applauncher"
      class="applauncher"
      anchor={TOP | BOTTOM | LEFT | RIGHT}
      exclusivity={Astal.Exclusivity.IGNORE}
      keymode={Astal.Keymode.EXCLUSIVE}
      onNotifyVisible={({ visible }) => {
        if (visible) searchentry.grab_focus()
        else searchentry.set_text("")
      }}
    >
      <Gtk.EventControllerKey
        onKeyPressed={(
          _e: Gtk.EventControllerKey,
          keyval: number,
          _: number,
          mod: number,
        ) => {
          if (keyval === Gdk.KEY_Escape) {
            win.visible = false
            return
          }
          if (mod === Gdk.ModifierType.ALT_MASK) {
            for (const i of [1, 2, 3, 4, 5, 6, 7, 8, 9] as const) {
              if (keyval === Gdk[`KEY_${i}`]) {
                return launch(list.get()[i - 1])
              }
            }
          }
        }} />
      <Gtk.GestureClick
        onPressed={(_e: Gtk.GestureClick, _: number, x: number, y: number) => {
          const [, rect] = contentbox.compute_bounds(win)
          const position = new Graphene.Point({ x, y })
          if (!rect.contains_point(position)) {
            win.visible = false
            return true
          }
        }} />
      <box
        $={(ref) => (contentbox = ref)}
        name="applauncher-content"
        valign={Gtk.Align.CENTER}
        halign={Gtk.Align.CENTER}
        orientation={Gtk.Orientation.VERTICAL}
        spacing={4} >
        <entry
          $={(ref) => searchentry = ref}
          onActivate={() => launch(list.get()[0])}
          onNotifyText={(self) => search(self.text)}
          placeholderText="Start typing to search"
        />
        <Gtk.Separator visible={list((l) => l.length > 0)} />
        <box
          name="applauncher-applist"
          orientation={Gtk.Orientation.VERTICAL}
          spacing={2}>
          <For each={list}>
            {(app, index) => (
              <button onClicked={() => launch(app)}>
                <box>
                  <image
                    valign={Gtk.Align.CENTER}
                    halign={Gtk.Align.CENTER}
                    iconName={app.iconName} />
                  <label label={app.name} maxWidthChars={40} wrap />
                  <label
                    hexpand
                    halign={Gtk.Align.END}
                    label={index((i) => `Alt+${i + 1}`)}
                  />
                </box>
              </button>
            )}
          </For>
        </box>
      </box>
    </window>
  )
}
