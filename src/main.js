import Vue from "vue"
import Filtrations from "./filtrations"
import Notifications from "./notifications"

import * as config from "./config.js"
import view from "./view.vue"
import router from "./router.js"
import store from "./store.js"
import app from "./app.js"
import {VERSION, HASH} from "./version.js"

import {userWarning, timeSync, sound} from "./lib"

Vue.use(Filtrations);
Vue.use(Notifications);

Vue.component("version", {
	functional: true,
	render: function(createElement) {
		return createElement("span", VERSION);
	}
})

let vue = new Vue({
	router,
	store,
	el: "#app",
	render: h => h(view)
})

timeSync.maintainDelta(config.TIME_SYNC_DELTA);
timeSync.debug = config.DEBUG;
app.debug = config.DEBUG;

if (config.DEBUG) {
	window.vue = vue;
	window.app = app;
	window.router = router;
	window.store = store;
	window.sound = sound;
	window.VERSION = VERSION;
	window.HASH = HASH;
}

if (config.ENV == config.PROD) {
	userWarning();
}