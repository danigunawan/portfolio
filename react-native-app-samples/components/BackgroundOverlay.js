import React from 'react';
import { Image } from 'react-native';
import {normalize} from '../config/utils';

export default class BackgroundOverlay extends React.Component {
  render() {
    return (
      <Image style={{resizeMode:'cover',position:'absolute',width:'100%',height:520,opacity:.30,top:0,...this.props.style}} source={require('../assets/images/bg.png')} />
    );
  }
}
