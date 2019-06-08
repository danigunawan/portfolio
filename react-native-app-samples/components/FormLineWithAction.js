import React, { Component } from 'react';
import { View,TouchableOpacity,Text,Switch } from 'react-native';
import STYLES from '../config/styles';
import {normalize} from '../config/utils';

export default class FormLineWithAction extends Component {
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
      <View style={{display:'flex',marginBottom:15,paddingTop:10,paddingBottom:10,flexDirection:'row',borderBottomWidth:.5,...this.props.style}}>
        <View style={{flex:1,paddingRight:10}}>
          <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,color:'white',fontSize:18,fontWeight:'bold'}} numberOfLines={1}>{this.props.label}</Text>
        </View>
        <View style={{flexDirection:'column',display:'flex',justifyContent:'center'}}>
          <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,color:STYLES.COLORS.PRIMARY,fontSize:16,fontWeight:'bold',padding:0,alignSelf:'center'}}>{this.props.value}</Text>
        </View>
      </View>
    );
  }
}
