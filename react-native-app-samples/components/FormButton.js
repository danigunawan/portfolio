import React, { Component } from 'react';
import { View, TouchableOpacity, Text } from 'react-native';
import STYLES from '../config/styles';
import {normalize} from '../config/utils';

export default class FormButton extends Component {
  render() {
    return (
      <TouchableOpacity style={{width: '90%',alignItems:'center',justifyContent:'center',height: 50,backgroundColor:STYLES.COLORS.PRIMARY,borderRadius:10,...this.props.style}} onPress={this.props.onPress}>
        <Text allowFontScaling={false} style={{justifyContent:'center',alignItems:'center',color:'white',fontFamily:STYLES.FONT_FAMILY,fontWeight:'900',fontSize:15,textTransform:'uppercase'}}>{ this.props.label }</Text>
      </TouchableOpacity>
    );
  }
}
