import React from 'react';
import { Component } from 'react';
import { TouchableOpacity,Text,View,StatusBar,SafeAreaView } from 'react-native';
import { TabBarBottomProps, NavigationRoute } from 'react-navigation';
import LinearGradient from 'react-native-linear-gradient';
import Icon from './Icon';
import {normalize} from '../config/utils';

export default class TabBar extends Component {
    currentRouteName() {
      return this.props.navigation.state.routes[this.props.navigation.state.index].routeName
    }

    render() {
      console.log(this.props.navigation);
      var tab_bar = (
        <View style={[{width:'100%',position:'absolute',bottom:0,left:0,right:0}, this.props.style]}>
          <SafeAreaView style={{position:'relative',zIndex:1}} forceInset={{bottom:'always'}}>
            <View style={{flex:1,flexDirection:'row',zIndex:10,marginTop:12,paddingBottom:5,paddingLeft:10,paddingRight:10,justifyContent:'space-between'}}>
              <TouchableOpacity onPress={() => {this.props.navigation.navigate('Browse'); }} style={{flex:1}}>
                <View style={{alignItems:'center',flex:1,backgroundColor:'transparent',height:50,zIndex:10,opacity:(this.props.navigation.state.index === 0 ? 1 : .7)}}>
                  <Icon style={{color:'white',fontSize:20,marginTop:4}} name="Home"/>
                  <Text allowFontScaling={false} style={{color:'white',fontWeight:'normal',fontFamily:STYLES.FONT_FAMILY,fontSize:normalize(10),marginTop:0}}>Browse</Text>
                </View>
              </TouchableOpacity>
              <TouchableOpacity onPress={() => {this.props.navigation.navigate('Search'); }} style={{alignItems:'center',flex:1,backgroundColor:'transparent',height:50,zIndex:10}}>
                <View style={{alignItems:'center',flex:1,backgroundColor:'transparent',height:50,zIndex:10,opacity:(this.props.navigation.state.index === 1 ? 1 : .7)}}>
                  <Icon style={{color:'white',fontSize:20,marginTop:4}} name="search"/>
                  <Text allowFontScaling={false} style={{color:'white',fontWeight:'normal',fontFamily:STYLES.FONT_FAMILY,fontSize:normalize(10),marginTop:0}}>Search</Text>
                </View>
              </TouchableOpacity>
              <TouchableOpacity onPress={() => {this.props.navigation.navigate('PostForm',{lastRouteName:this.props.navigation.state.routeName}) }} style={{marginLeft:10,marginRight:10,alignItems:'center',width:55,backgroundColor:'transparent',height:50,zIndex:10,borderRadius:10,borderLeftColor:STYLES.COLORS.SECONDARY,borderLeftWidth:2.5,marginBottom:5,borderRightColor:STYLES.COLORS.PRIMARY,borderRightWidth:2.5}}>
                <View style={{width:'100%',height:50,borderRadius:STYLES.BORDER_RADIUS,borderWidth:2,borderColor:'white',alignItems:'center',display:'flex',flexDirection:'column'}}>
                  <View style={{flex:1}}/>
                  <Icon style={{color:'white',marginTop:5}} name="add"/>
                  <View style={{flex:1}}/>
                </View>
              </TouchableOpacity>
              <TouchableOpacity onPress={() => {this.props.navigation.navigate('Posts'); }} style={{alignItems:'center',flex:1,backgroundColor:'transparent',height:50,zIndex:10}}>
                <View style={{alignItems:'center',flex:1,backgroundColor:'transparent',height:50,zIndex:10,opacity:(this.props.navigation.state.index === 2 ? 1 : .7)}}>
                  <Icon style={{color:'white',fontSize:20,marginTop:4}} name="rows"/>
                  <Text allowFontScaling={false} style={{color:'white',fontWeight:'normal',fontFamily:STYLES.FONT_FAMILY,fontSize:normalize(10),marginTop:0}}>Posts</Text>
                </View>
              </TouchableOpacity>
              <TouchableOpacity onPress={() => {this.props.navigation.navigate('Account'); }} style={{alignItems:'center',flex:1,backgroundColor:'transparent',height:50,zIndex:10}}>
                <View style={{alignItems:'center',flex:1,backgroundColor:'transparent',height:50,zIndex:10,opacity:(this.props.navigation.state.index === 3 ? 1 : .7)}}>
                  <Icon style={{color:'white',fontSize:20,marginTop:4}} name="user"/>
                  <Text allowFontScaling={false} style={{color:'white',fontWeight:'normal',fontFamily:STYLES.FONT_FAMILY,fontSize:normalize(10),marginTop:0}}>Account</Text>
                </View>
              </TouchableOpacity>
            </View>
          </SafeAreaView>
          <LinearGradient colors={['transparent', 'rgba(0,0,0,.3)', 'rgba(0,0,0,.9)', 'rgba(0,0,0,1)']} locations={[0,0.1,0.5,1]}  style={{zIndex:0,position:'absolute',width:'100%',height:'100%',top:0,left:0,right:0,bottom:0}}/>
        </View>
      );

      return (tab_bar);
    }
}
