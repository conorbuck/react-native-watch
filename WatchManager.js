var React = require('react-native');
var {
	NativeAppEventEmitter,
	NativeModules
} = require('react-native');

var WatchManager = NativeModules.WatchManager;

module.exports = {

	activate: () => {
		WatchManager.activate();
	},

	addMessageListener: (callback, context: null) => {
		return NativeAppEventEmitter.addListener('onWatchMessage', (message) => {
			callback.call(context, message);
		});
	},

	removeMessageListener: subscription => {
		subscription.remove();
	},

	sendMessage: msg => {
		WatchManager.sendMessage(msg);
	}
};