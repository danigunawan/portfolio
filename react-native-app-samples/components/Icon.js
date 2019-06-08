import React from 'react';
import { Text } from 'react-native';
import STYLES from '../config/styles';
import {normalize} from '../config/utils';

export default class Icon extends React.Component {
  render() {
    return (
      <Text allowFontScaling={false} style={{color:'white',fontFamily:STYLES.ICON_FONT_FAMILY,fontSize:20,fontWeight:'900',...this.props.style}}>{this.props.name}</Text>
    );
  }
}
