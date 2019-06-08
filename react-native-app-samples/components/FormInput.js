import React, { Component } from 'react';
import { View, TextInput, TouchableWithoutFeedback, Keyboard } from 'react-native';
import STYLES from '../config/styles';
import {normalize} from '../config/utils';

export default class FormInput extends Component {
  render() {
    return (
      <TouchableWithoutFeedback onPress={Keyboard.dismiss} accessible={false}>
        <View style={{width:'90%',borderRadius:STYLES.BORDER_RADIUS,overflow:'hidden',marginBottom:20,padding:normalize(5),backgroundColor:this.props.invalid ? 'indianred' : (this.props.valid ? 'limegreen' : 'whitesmoke')}}>
          <TextInput allowFontScaling={false} autoFocus={this.props.autoFocus} autoCapitalize={this.props.autoCapitalize} value={this.props.value} onChangeText={this.props.onChangeText} secureTextEntry={this.props.secureTextEntry} style={{backgroundColor:'whitesmoke',borderRadius:5,overflow:'hidden',padding:normalize(8),paddingTop:normalize(11),fontSize:15,fontWeight:'800',letterSpacing:0,fontFamily:STYLES.FONT_FAMILY}} placeholder={this.props.label} placeholderTextColor={'#666'}/>
        </View>
      </TouchableWithoutFeedback>
    );
  }
}
