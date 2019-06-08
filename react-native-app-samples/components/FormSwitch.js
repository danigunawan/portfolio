import React, { Component } from 'react';
import { View,TouchableOpacity,Text,Switch } from 'react-native';
import STYLES from '../config/styles';
import {normalize} from '../config/utils';

export default class FormButton extends Component {
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
        <View style={{flex:1,paddingRight:10}}>
          <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,color:'white',fontSize:18,fontWeight:'bold'}} numberOfLines={1}>{this.props.label}</Text>
          <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,color:'white',fontSize:16,fontWeight:'bold',opacity:.8}} numberOfLines={1}>{this.props.description}</Text>
        </View>
        <View style={{flexDirection:'column',display:'flex',justifyContent: 'center'}}>
          <Switch value={this.state.switchValue} onTintColor={STYLES.COLORS.PRIMARY} onValueChange={this.toggleSwitch}/>
        </View>
      </View>
    );
  }
}
