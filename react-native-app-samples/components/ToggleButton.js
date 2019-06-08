import React, { Component } from 'react';
import { View, TouchableOpacity, Text } from 'react-native';
import STYLES from '../config/styles';
import {normalize} from '../config/utils';

export default class ToggleButton extends Component {
  constructor(props) {
    super(props);
    this.state = {active:props.active};
  }

  toggleButton = () => {
    this.setState({active:!this.state.active});
    if (this.props.onPress) this.props.onPress(this.state.active);
  }

  render() {
    return (
      <TouchableOpacity style={{alignItems:'center',display:'flex',justifyContent:'center',padding:12,paddingTop:5,paddingBottom:4,borderRadius:100,...this.props.style,backgroundColor:this.state.active ? 'limegreen' : 'rgba(255,255,255,.9)'}} onPress={this.toggleButton}>
        <Text allowFontScaling={false} style={{justifyContent:'center',fontFamily:STYLES.FONT_FAMILY,fontWeight:'900',fontSize:12,...this.props.labelStyle,color:this.state.active ? 'white' : 'rgb(30,30,30)'}}>{ this.props.label }</Text>
      </TouchableOpacity>
    );
  }
}
