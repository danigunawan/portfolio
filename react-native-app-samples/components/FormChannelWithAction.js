import React, { Component } from 'react';
import { View, Text, TouchableOpacity } from 'react-native';
import STYLES from '../config/styles';
import {normalize} from '../config/utils';
import FontAwesomeIcon from 'react-native-vector-icons/FontAwesome';
import ChannelAvatar from './ChannelAvatar';

export default class FormChannelWithAction extends Component {
  render() {
    return (
      <View style={{display:'flex',marginBottom:15,flexDirection:'row',...this.props.style}}>
        <View style={{width:80}}>
          <ChannelAvatar source={require('../assets/images/author-demo.jpg')} />
        </View>
        <View style={{flex:1,paddingLeft:20,paddingTop:10,paddingRight:10}}>
          <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,color:'white',fontSize:18,fontWeight:'bold'}} numberOfLines={1}>Pineapple Kush</Text>
          <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,color:'white',fontSize:16,fontWeight:'bold',opacity:.8}} numberOfLines={1}>Facebook Page</Text>
          <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,color:'white',fontSize:14,opacity:.8}} numberOfLines={1}>45 posts</Text>
        </View>
        <TouchableOpacity style={{flexDirection:'column',display:'flex',justifyContent: 'center'}}>
          <Text allowFontScaling={false} style={{...STYLES.LINK,color:STYLES.COLORS.PRIMARY,textDecorationLine:'none',fontSize:16}}>Remove</Text>
        </TouchableOpacity>
      </View>
    );
  }
}
