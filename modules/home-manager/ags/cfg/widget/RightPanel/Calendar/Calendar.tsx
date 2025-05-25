import { astalify, ConstructProps, Gtk, } from "astal/gtk3"
import { GObject } from "astal"

class Calendar extends astalify(Gtk.Calendar) {
  static {
    GObject.registerClass(this);
  }

  constructor(
    props: ConstructProps<Gtk.Calendar, Gtk.Calendar.ConstructorProps>,
  ) {
    super(props as any);
  }
}

export default () => {
  return <box className={"calendar"}>
    {new Calendar({
      hexpand: true,
      vexpand: true
    })}
  </box>
};
