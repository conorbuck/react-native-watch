/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
} = React;

var WatchManager = require('./WatchManager.js');

class WatchDemo extends React.Component {

  constructor(props) {
    super(props)

    this.state = {
      value: 0
    }
  }

  componentDidMount() {
    // Setup the Watch Manager
    WatchManager.activate();
    WatchManager.addMessageListener(msg => {
      let value = this.state.value + 1;

      // update watch
      WatchManager.sendMessage({
        value
      });

      // update our view
      this.setState({
        value
      })
    });
  }

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>Value:{this.state.value}</Text>
      </View>
    );
  }
};

var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('WatchDemo', () => WatchDemo);
