import React, { Component } from 'react';
import { View, TouchableOpacity, Text } from 'react-native';
import STYLES from '../config/styles';
import {normalize} from '../config/utils';
import Icon from './Icon';

export default class TopNavButton extends Component {
  render() {
    return (
      <TouchableOpacity style={{top:0,position:'absolute',padding:10,left:10,flexDirection:'row',...this.props.style}} onPress={() => this.props.onPress ? this.props.onPress() : this.props.navigation.navigate(this.props.navigation.state.params.lastRouteName)}>
        <Icon style={{...this.props.iconStyle}} name={this.props.icon}/>
        <Text allowFontScaling={false} style={{justifyContent:'center',color:'white',fontFamily:STYLES.FONT_FAMILY,fontWeight:'900',fontSize:10,paddingLeft:5,paddingTop:5,...this.props.labelStyle}}>{ this.props.label }</Text>
      </TouchableOpacity>
    );
  }
}
