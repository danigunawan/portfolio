import React from 'react';
import { View,Text } from 'react-native';
import Avatar from './Avatar';
import STYLES from '../config/styles';
import {normalize} from '../config/utils';

export default class AuthorAvatar extends React.Component {
  render() {
    return (
      <View style={{flex:1,aspectRatio:.7,backgroundColor:'blue',alignItems:'center',...this.props.style}}>
        <Avatar source={this.props.source}></Avatar>
        <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,fontSize:14,marginTop:10,fontWeight:'700',color:'white'}} numberOfLines={1}>{this.props.name}</Text>
      </View>
    );
  }
}
