import React, { Component } from 'react';
import { View, Text, TouchableOpacity } from 'react-native';
import STYLES from '../config/styles';
import {normalize} from '../config/utils';
import FontAwesomeIcon from 'react-native-vector-icons/FontAwesome';
import ChannelAvatar from './ChannelAvatar';

import FacebookImage from '../assets/images/facebook.png';
import TwitterImage from '../assets/images/twitter.png';
import InstagramImage from '../assets/images/instagram.png';
import YoutubeImage from '../assets/images/youtube.png';
import LinkedinImage from '../assets/images/linkedin.png';
import PinterestImage from '../assets/images/pinterest.png';

const networks = {
  'facebook': {
    icon: FacebookImage,
    label: 'Facebook'
  },

  'twitter': {
    icon: TwitterImage,
    label: 'Twitter'
  },

  'instagram': {
    icon: InstagramImage,
    label: 'Instagram'
  },

  'youtube': {
    icon: YoutubeImage,
    label: 'YouTube'
  },

  'linkedin': {
    icon: LinkedinImage,
    label: 'LinkedIn'
  },

  'pinterest': {
    icon: PinterestImage,
    label: 'Pinterest'
  }
}

export default class ConnectNetworkButton extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <View style={{display:'flex',marginBottom:15,flexDirection:'row',...this.props.style}}>
        <View style={{height:60}}>
          <ChannelAvatar source={networks[this.props.network].icon}/>
        </View>
        <View style={{flex:1,paddingLeft:20,justifyContent:'center',paddingRight:10}}>
          <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,color:'white',fontSize:18,fontWeight:'bold'}} numberOfLines={1}>{networks[this.props.network].label} Page</Text>
        </View>
        <TouchableOpacity style={{flexDirection:'column',display:'flex',justifyContent: 'center'}}>
          <Text allowFontScaling={false} style={{...STYLES.LINK,color:STYLES.COLORS.PRIMARY,textDecorationLine:'none',fontSize:16}}>Add</Text>
        </TouchableOpacity>
      </View>
    );
  }
}
