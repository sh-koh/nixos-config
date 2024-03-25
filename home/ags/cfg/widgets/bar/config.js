import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';
import Tag from './tags.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';

const Date = () => Widget.Label({
  class_name: 'date',
  setup: self => self.poll(1000, () => {
    Utils.execAsync('date "+%D"').then(date => self.label = date + " ")
    Utils.execAsync('date "+%A %d %B"').then(date => self.tooltip_text = date.replace(/^./, str => str.toUpperCase()));
  }),
});

const Clock = () => Widget.Label({
  class_name: 'clock',
  setup: self => self.poll(1000, () => {
    Utils.execAsync('date "+%H:%M"').then(time => self.label = time + " ");
  }),
});

const openDrawer = () => Widget.Button({
  class_name: 'powermenu',
  label: '',
  on_primary_click: () => print('hello :D'),
});

const Microphone = () => Widget.EventBox({
	class_name: 'audio-microphone',
  on_primary_click: () => Audio.microphone.volume === 0 ? Audio.microphone.volume = 1 : Audio.microphone.volume = 0,
  on_secondary_click: self => {
    let child = self.child["children"][0]; 
    child.reveal_child = !child.reveal_child;
  },
  on_scroll_up: () => {
    if (Audio.microphone.volume + 0.05 > 1) {
      Audio.microphone.volume = 1;
    } else {
      Audio.microphone.volume = Audio.microphone.volume + 0.05;
    } 
  },
  on_scroll_down: () => {
    Audio.microphone.volume = Audio.microphone.volume - 0.05;
  },
  child: Widget.Box({
	  children: [
      Widget.Revealer({
        revealChild: false,
        transitionDuration: 300,
        transition: 'slide_left',
        child: Widget.Slider({
      		hexpand: true,
          vertical: false,
      		draw_value: false,
      		on_change: ({ value }) => Audio.microphone.volume = value,
      		setup: self => self.hook(Audio, () => {
      			self.value = Audio.microphone?.volume || 0;
      		}, 'microphone-changed'),
      	}),
      }),
      Widget.Icon().hook(Audio, self => {
	  	  if (!Audio.microphone)
	  	  	return;
	  	  Audio.microphone.is_muted ? self.icon = `audio-input-microphone-muted` : self.icon = `microphone`;
	  	}, 'microphone-changed'),
    ],
  }),
});

const Speakers = () => Widget.EventBox({
	class_name: 'audio-speaker',
  on_primary_click: () => Audio.speaker.volume === 0 ? Audio.speaker.volume = 1 : Audio.speaker.volume = 0,
  on_secondary_click: self => {
    let child = self.child["children"][0]; 
    child.reveal_child = !child.reveal_child;
  },
  on_scroll_up: () => {
    if (Audio.speaker.volume + 0.05 > 1) {
      Audio.speaker.volume = 1;
    } else {
      Audio.speaker.volume = Audio.speaker.volume + 0.05;
    }
  },
  on_scroll_down: () => {
    Audio.speaker.volume = Audio.speaker.volume - 0.05;
  },
  child: Widget.Box({
	  children: [
      Widget.Revealer({
        revealChild: false,
        transitionDuration: 300,
        transition: 'slide_left',
        child: Widget.Slider({
        	hexpand: true,
          vertical: false,
        	draw_value: false,
        	on_change: ({ value }) => Audio.speaker.volume = value,
        	setup: self => self.hook(Audio, () => {
        		self.value = Audio.speaker?.volume || 0;
        	}, 'speaker-changed'),
        }),
      }),
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
	  		const icon = Audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(threshold => threshold <= Audio.speaker.volume * 100);
	  		self.icon = `audio-volume-${category[icon]}-symbolic`;
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

const Left = () => Widget.Box({
	spacing: 4,
	children: [
    openDrawer(),
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
		Speakers(),
    Microphone(),
		LaptopBattery(),
		Clock(),
    Date(),
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
