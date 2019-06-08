import React, { Component } from 'react';
import { View,TouchableOpacity,Text,Switch } from 'react-native';
import STYLES from '../config/styles';
import {normalize} from '../config/utils';

export default class FormLink extends Component {
  constructor(props) {
    super(props);
    this.state = {switchValue:false}
    this.toggleSwitch = this.toggleSwitch.bind(this);
  }

  toggleSwitch() {
    this.setState(previousState => {
      return { switchValue: !previousState.switchValue };
    });
  }

  render() {
    return (
      <View style={{display:'flex',marginBottom:15,paddingTop:5,paddingBottom:5,flexDirection:'row',...this.props.style}}>
        <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,color:STYLES.COLORS.PRIMARY,fontSize:14,fontWeight:'bold',padding:10,...this.props.labelStyle}}>{this.props.label}</Text>
      </View>
    );
  }
}
