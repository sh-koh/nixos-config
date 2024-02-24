import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';
//import River from '../../services/river.js';
import Tag from './tags.js';
import SystemTray from 'resource:///com/github/Aylur/ags/service/systemtray.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';

const Date = () => Widget.Label({
  class_name: 'date',
  setup: self => self.poll(1000, () => {
    Utils.execAsync('date "+%A %d %B"').then(date => self.label = date.replace(/^./, str => str.toUpperCase()));
  })
});

const Clock = () => Widget.Label({
  class_name: 'clock',
	setup: self => self.poll(1000, () => {
		Utils.execAsync('date "+%H:%M"').then(time => self.label = time);
	})
});

const openDrawer = () => Widget.Button({
  class_name: 'powermenu',
  label: '',
  on_primary_click: () => print('hello :D'),
});

const Volume = () => Widget.Box({
	class_name: 'volume',
	children: [
		Widget.Icon().hook(Audio, self => {
			if (!Audio.speaker)
				return;

			const category = {
				101: 'overamplified',
				67: 'high',
				34: 'medium',
				1: 'low',
				0: 'muted',
			};

			const icon = Audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
				threshold => threshold <= Audio.speaker.volume * 100);

			self.icon = `audio-volume-${category[icon]}-symbolic`;
		}, 'speaker-changed'),
		Widget.Slider({
			hexpand: true,
      vertical: false,
			draw_value: false,
			on_change: ({ value }) => Audio.speaker.volume = value,
			setup: self => self.hook(Audio, () => {
				self.value = Audio.speaker?.volume || 0;
			}, 'speaker-changed'),
		}),
	],
});

const LaptopBattery = () => Widget.Box({
	class_name: 'battery',
	visible: Battery.bind('available'),
	children: [
		Widget.Icon({
			icon: Battery.bind('percent').transform(p => {
				return `battery-level-${Math.floor(p / 10) * 10}-symbolic`;
			}),
		}),
		Widget.Label({
			label: Battery.bind('percent').transform(p => {
        return `- ${p}%`;
      }),
		}),
	],
});

const SysTray = () => Widget.Box({
	class_name: 'systray',
	children: SystemTray.bind('items').transform(items => {
		return items.map(item => Widget.Button({
			child: Widget.Icon({ binds: [['icon', item, 'icon']] }),
			on_primary_click: (_, event) => item.activate(event),
			on_secondary_click: (_, event) => item.openMenu(event),
			binds: [['tooltip-markup', item, 'tooltip-markup']],
		}));
	}),
});

const Left = () => Widget.Box({
	spacing: 4,
	children: [
    openDrawer(),
    Date(),
	],
});

const Center = (monitor) => Widget.Box({
	spacing: 4,
	children: [
    Tag(monitor),
	],
});

const Right = () => Widget.Box({
	hpack: 'end',
	spacing: 4,
	children: [
		Volume(),
		LaptopBattery(),
		Clock(),
		SysTray(),
	],
});

const Layout = (monitor) => Widget.CenterBox({
	start_widget: Left(),
	center_widget: Center(monitor),
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
