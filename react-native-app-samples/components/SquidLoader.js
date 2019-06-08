import React from 'react';
import { Animated, Image, View } from 'react-native';
import {normalize} from '../config/utils';

export default class SquidLoader extends React.Component {
  spinValue = new Animated.Value(0)

  componentDidMount() {
    Animated.loop(Animated.timing(this.spinValue,{toValue: 1,duration: 1500})).start()
  }

  render() {
    // Second interpolate beginning and end values (in this case 0 and 1)
    const spin = this.spinValue.interpolate({
      inputRange: [0, 1],
      outputRange: ['0deg', '360deg']
    })

    return (
      <Animated.Image style={{...this.props.style, width:100, height: 100, transform: [{rotate: spin}]}} source={require('../assets/images/squid-with-shadow.png')}/>
    );
  }
}
