import React from 'react';
import { Text,StatusBar,View,Image,Linking } from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import Avatar from './Avatar';
import Icon from './Icon';
import STYLES from '../config/styles';
import {normalize} from '../config/utils';

export default class Post extends React.Component {
  render() {
    return (
      <View style={{flex:1,width:'100%',...this.props.style}}>
        <StatusBar barStyle="light-content" />
        <View style={{zIndex:1,flex:1}}>
          <Image style={{resizeMode:'cover',position:'absolute',width:'100%',height:'90%',opacity:1,top:0}} source={require('../assets/images/post-demo.jpg')}/>
          <LinearGradient colors={['rgba(0,0,0,0)','rgba(0,0,0,1)']} style={{zIndex:1,position:'absolute',width:'100%',height:100,bottom:'10%',right:0}}/>
        </View>
        <View style={{zIndex:2,position:'absolute',bottom:0,left:0,right:0,padding:20,paddingBottom:10}}>
          <View style={{flex:1,flexDirection:'row',paddingBottom:10,alignItems:'flex-end'}}>
            <View style={{flex:1,alignItems:'flex-start'}}>
              <View style={{width:40}}>
                <Avatar source={require('../assets/images/author-demo.jpg')} />
              </View>
              <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,fontSize:14,marginTop:8,fontWeight:'700',color:'white'}} numberOfLines={1}>Nicole</Text>
            </View>
            <View style={{flex:1,alignItems:'flex-end'}}>
              <Text allowFontScaling={false} style={{...STYLES.LINK,fontSize:20,fontWeight:'900',marginBottom:5,textDecorationLine:'none',padding:0}}>Free</Text>
              <View style={{flex:1,alignItems:'flex-end',flexDirection:'row'}}><Icon style={{marginLeft:10}} name="link"/><Icon style={{marginLeft:10}} name="video"/></View>
              <Text allowFontScaling={false} style={{...STYLES.LINK,fontSize:14,textDecorationLine:'none',padding:0,marginTop:0}} onPress={() => Linking.openURL('http://www.entrepreneur.com/')}>entrepreneur.com</Text>
            </View>
          </View>
          <Text allowFontScaling={false} style={{color:'white',fontFamily:STYLES.FONT_FAMILY,fontSize:16,fontWeight:'700',letterSpacing:0}}>In the season finale of Entrepreneur Elevator Pitch, the investors have never been so impressed.</Text>
        </View>
      </View>
    );
  }
}
