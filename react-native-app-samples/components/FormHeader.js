import React, { Component } from 'react';
import { View, TouchableOpacity, Text } from 'react-native';
import STYLES from '../config/styles';
import {normalize} from '../config/utils';

export default class FormButton extends Component {
  render() {
    return (
      <View style={{padding:5,paddingTop:10,marginBottom:20,marginTop:25,borderBottomWidth:2,borderBottomColor:'rgba(255,255,255,.2)'}}>
        <Text allowFontScaling={false} style={{flex:1,color:'white',fontFamily:STYLES.FONT_FAMILY,fontWeight:'900',fontSize:22}}>{ this.props.label }</Text>
      </View>
    );
  }
}
