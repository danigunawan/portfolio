import React from 'react';
import { Text } from 'react-native';
import STYLES from '../config/styles';
import {normalize} from '../config/utils';

export default class Headline extends React.Component {
  render() {
    return (
      <Text allowFontScaling={false} style={{color:'white',fontFamily:STYLES.FONT_FAMILY,fontSize:24,fontWeight:'900',letterSpacing:-.5,marginBottom:20,marginTop:20,...this.props.style}}>{this.props.text}</Text>
    );
  }
}
