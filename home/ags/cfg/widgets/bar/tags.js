import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';

export const Bedload = Variable([], {
  listen:[['bash', '-c', 'river-bedload -minified -watch tags'], out => JSON.parse(out)],
});

const Tag = (tag, monitor) => Widget.Button({
  label: `${tag}`,
  class_name: 'tags',
  on_primary_click: () => Utils.execAsync(['bash', '-c', `riverctl set-focused-tags $((1 << (${tag} - 1)))`]),
  on_secondary_click: () => Utils.execAsync(['bash', '-c', `riverctl toggle-focused-tags $((1 << (${tag} - 1)))`]),
  setup: self => self.hook(Bedload, self => {
    const Monitors = [...new Set(Bedload.getValue().map(info => info.output).reverse())];
    const queryTags = () => Bedload.value.find(obj => obj.id === tag && obj.output === Monitors[monitor]);
    if (queryTags().focused) {
      self.class_name = 'tags-focused'
    } else if (queryTags().occupied) {
      self.class_name = 'tags-occupied'
    } else {
      self.class_name = 'tags'
    }
  }),
});

export default (monitor) => Widget.Box({
  hpack:'center',
  class_name: 'tags',
  spacing: 4,
  children: Array.from({ length: 9 }, (_, i) => i + 1).map(i => Tag(i, monitor))
});
