import React from 'react';
import { Image,View } from 'react-native';
import {normalize} from '../config/utils';

export default class Avatar extends React.Component {
  render() {
    return (
      <View style={{flex:1,borderRadius:100,overflow:'hidden',height:'100%',aspectRatio: 1,shadowColor: '#000',shadowOffset: { width: 5, height: 2 },shadowOpacity: 0.8,shadowRadius: 10}}>
        <Image style={{resizeMode:'cover',position:'absolute',width:'100%',height:'100%',alignSelf:'center'}} source={this.props.source} />
      </View>
    );
  }
}
