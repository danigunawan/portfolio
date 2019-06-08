import React from 'react';
import { View, SafeAreaView, TouchableOpacity, Text, StyleSheet } from 'react-native';
import STYLES from '../config/styles';
import {normalize} from '../config/utils';

export default class FullWidthButton extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <TouchableOpacity style={{display: 'flex',flexDirection: 'row',alignItems:'center',justifyContent:'center',height:70,backgroundColor: STYLES.COLORS.PRIMARY,width:'100%',alginSelf:'stretch',...this.props.style}} onPress={()=>{this.props.onPress()}}>
        <Text allowFontScaling={false} style={{justifyContent:'center',alignItems:'center',color:'white',fontFamily:STYLES.FONT_FAMILY,fontWeight:'900',fontSize:25,textTransform:'uppercase'}}>{ this.props.label }</Text>
      </TouchableOpacity>
    );
  }
}
