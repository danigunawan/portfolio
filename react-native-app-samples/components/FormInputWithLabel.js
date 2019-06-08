import React, { Component } from 'react';
import { View, TextInput } from 'react-native';
import STYLES from '../config/styles';
import {normalize} from '../config/utils';
import FontAwesomeIcon from 'react-native-vector-icons/FontAwesome';
import { Sae } from 'react-native-textinput-effects';

export default class FormInput extends Component {
  render() {
    return (
      <View style={this.props.style}>
        <Sae
          allowFontScaling={false} 
          label={this.props.label}
          iconClass={FontAwesomeIcon}
          iconName={this.props.iconName || 'pencil'}
          iconColor={'white'}
          autoCapitalize={'none'}
          autoCorrect={false}
          value={this.props.value}
          labelStyle={{color:STYLES.COLORS.PRIMARY}}
          inputStyle={{color:'white'}}
        />
      </View>
    );
  }
}
