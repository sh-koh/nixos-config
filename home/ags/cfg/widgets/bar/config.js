import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';

const Date = () => Widget.Label({
  class_name: 'date',
  setup: self => self.poll(1000, () => {
    Utils.execAsync('date "+%d/%m"').then(date => self.label = date + " 󰸗")
    Utils.execAsync('date "+%A %d %B"').then(date => self.tooltip_text = date.replace(/^./, str => str.toUpperCase()));
  }),
});

const Clock = () => Widget.Label({
  class_name: 'clock',
  setup: self => self.poll(1000, () => {
    Utils.execAsync('date "+%H:%M"').then(time => self.label = time + " 󱑂");
  }),
});

const OpenDrawer = () => Widget.Button({
  class_name: 'powermenu',
  label: '',
  on_primary_click_release: () => print('hello :D'),
});

let speaker_volume = 0.5;
let mic_volume = 1;

const Microphone = () => Widget.EventBox({
  class_name: 'audio-microphone',
  on_primary_click_release: self => {
    let child = self.child["children"][0];
    child.reveal_child = !child.reveal_child;
  },
  on_secondary_click_release: () => {
    if (Audio.microphone.volume !== 0) {
      mic_volume = Audio.microphone.volume;
    }
    Audio.microphone.volume === 0 ? Audio.microphone.volume = mic_volume : Audio.microphone.volume = 0;
  },
  on_scroll_up: () => {
    if (Audio.microphone.volume + 0.05 > 1) {
      Audio.microphone.volume = 1;
    } else {
      Audio.microphone.volume = Audio.microphone.volume + 0.05;
    }
  },
  on_scroll_down: () => Audio.microphone.volume = Audio.microphone.volume - 0.05,
  child: Widget.Box({
    children: [
      Widget.Revealer({
        revealChild: true,
        transitionDuration: 300,
        transition: 'slide_left',
        child: Widget.Slider({
          hexpand: true,
          vertical: true,
          inverted: true,
          draw_value: false,
          on_change: ({ value }) => Audio.microphone.volume = value,
          setup: self => self.hook(Audio, () => {
            self.value = Audio.microphone?.volume || 0;
          }, 'microphone-changed'),
        }),
      }),
      Widget.Label().hook(Audio, self => {
        if (!Audio.microphone)
          return;
        const icons = {
          0: '󰍭',
          1: '󰍬',
        };
        const selector = Audio.microphone.is_muted ? 0 : [1, 0].find(threshold => threshold <= Audio.microphone.volume * 100);
        self.label = `${icons[selector]}`
      }, 'microphone-changed'),
    ],
  }),
});

const Speakers = () => Widget.EventBox({
  class_name: 'audio-speaker',
  on_primary_click_release: self => {
    let child = self.child["children"][0];
    child.reveal_child = !child.reveal_child;
  },
  on_secondary_click_release: () => {
    if (Audio.speaker.volume !== 0) {
      speaker_volume = Audio.speaker.volume;
    }
    Audio.speaker.volume === 0 ? Audio.speaker.volume = speaker_volume : Audio.speaker.volume = 0;
  },
  on_scroll_up: () => {
    if (Audio.speaker.volume + 0.05 > 1) {
      Audio.speaker.volume = 1;
    } else {
      Audio.speaker.volume = Audio.speaker.volume + 0.05;
    }
  },
  on_scroll_down: () => Audio.speaker.volume = Audio.speaker.volume - 0.05,
  child: Widget.Box({
    children: [
      Widget.Revealer({
        revealChild: true,
        transitionDuration: 300,
        transition: 'slide_right',
        child: Widget.Slider({
          hexpand: true,
          vertical: true,
          draw_value: false,
          inverted: true,
          on_change: ({ value }) => Audio.speaker.volume = value,
          setup: self => self.hook(Audio, () => {
            self.value = Audio.speaker?.volume || 0;
          }, 'speaker-changed'),
        }),
      }),
      Widget.Label().hook(Audio, self => {
        if (!Audio.speaker)
          return;
        const icons = {
          0: '󰸈',
          1: '󰕿',
          34: '󰖀',
          67: '󰕾'
        };
        const selector = Audio.speaker.is_muted ? 0 : [67, 34, 1, 0].find(threshold => threshold <= Audio.speaker.volume * 100);
        self.label = `${icons[selector]}`
      }, 'speaker-changed'),
    ],
  }),
});

const LaptopBattery = () => Widget.Box({
  class_name: 'battery',
  visible: Battery.bind('available'),
  children: [
    Widget.Label({
      label: Battery.bind('percent').transform(p => {
        return `${p}%`;
      }),
    }),
    Widget.Icon({
      icon: Battery.bind('percent').transform(p => {
        return `battery-level-${Math.floor(p / 10) * 10}-symbolic`;
      }),
    }),
  ],
});

const Workspaces = (mon) => Widget.Box({
  spacing: 3,
  class_name: 'workspaces',
  children: Array.from({ length: 9 }, (_, i) => i + 1 + mon * 10).map(i => Widget.Button({
    label: `${i - mon * 10}`,
    on_primary_click_release: () => Hyprland.messageAsync(`dispatch split-workspace ${i}`),
    on_secondary_click_release: () => Hyprland.messageAsync(`dispatch split-movetoworkspacesilent ${i}`),
    setup: self => self.hook(Hyprland, () => {
      if (i === Hyprland.active.workspace.id) {
        self.class_name = 'focused'
      } else if (Hyprland.workspaces.some(ws => ws.id === i)) {
        self.class_name = 'occupied'
      } else {
        self.class_name = ''
      }
    }),
  })),
})

const Left = () => Widget.Box({
  spacing: 3,
  children: [
    OpenDrawer(),
  ],
});

const Center = (mon) => Widget.Box({
  spacing: 3,
  children: [
    Workspaces(mon),
  ],
});

const Right = () => Widget.Box({
  hpack: 'end',
  spacing: 3,
  children: [
    Speakers(),
    Microphone(),
    LaptopBattery(),
    Clock(),
    Date(),
  ],
});

const Layout = (mon) => Widget.CenterBox({
  start_widget: Left(),
  center_widget: Center(mon),
  end_widget: Right(),
})

export default (monitor) => Widget.Window({
  name: `bar-${monitor}`,
  class_name: 'bar',
  monitor,
  anchor: ['top', 'left', 'right'],
  exclusivity: 'exclusive',
  child: Layout(monitor)
});
