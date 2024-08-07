import Bar from './widgets/bar/config.js';
import { NotificationPopups } from './widgets/notifications/popups.js';
import App from 'resource:///com/github/Aylur/ags/app.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';

const scss = App.configDir + "/style.scss";
const css = App.configDir + "/style.css";

Utils.exec(`sass ${scss} ${css}`);

function reloadCss() {
	Utils.exec(`sass ${scss} ${css}`);
	App.resetCss();
	App.applyCss(css);
}

Utils.monitorFile(scss, reloadCss);

export default {
	style: css,
	windows: [
    NotificationPopups(0),
    NotificationPopups(1),
    Bar(0),
    Bar(1),
	],
};
