import React from 'react';
import { Image } from 'react-native';
import {normalize} from '../config/utils';

export default class SquidIcon extends React.Component {
  render() {
    return (
      <Image style={{resizeMode:'contain',position:'relative',width:100,height:100}} source={require('../assets/images/squid.png')} />
    );
  }
}
