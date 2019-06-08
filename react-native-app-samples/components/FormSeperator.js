import React, { Component } from 'react';
import { View, Text } from 'react-native';
import STYLES from '../config/styles';
import {normalize} from '../config/utils';

export default class FormSeperator extends Component {
  render() {
    return (
      <View style={{flexDirection:'row',width:'90%',height:20,opacity:.8,marginTop:12,marginBottom:12}}>
        <View style={{backgroundColor:'white',flex:1,height:3,marginTop:7,borderRadius:10,opacity:.8}}/>
        <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,paddingLeft:10,paddingRight:10,lineHeight:18,fontWeight:'900'}}>{this.props.label}</Text>
        <View style={{backgroundColor:'white',flex:1,height:3,marginTop:7,borderRadius:10,opacity:.8}}/>
      </View>
    );
  }
}
