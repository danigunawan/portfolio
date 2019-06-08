import React,{ Component } from 'react';
import { View, StatusBar,SafeAreaView,Text,TouchableOpacity } from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import STYLE from '../config/styles';
import {normalize} from '../config/utils';
import TopGradient from './TopGradient';

export default class TopTabBar extends Component {
    render() {
      let tabs = this.props.navigation.state.routes.map((i)=>{
        return (
          <TouchableOpacity
            key={i.routeName}
            style={{margin:10,marginTop:15,flex:1,alignItems:'center',zIndex:10}}
            onPress={()=>{this.props.navigation.navigate(i.routeName)}}>
            <Text allowFontScaling={false} style={{...STYLE.PARAGRAPH,color:'white',fontSize:20,fontWeight:'bold',opacity:this.props.navigation.state.routes[this.props.navigation.state.index].routeName == i.routeName ? 1 : .8}}>
              { i.routeName}
            </Text>
          </TouchableOpacity>)
      })
      return (
        <View style={[{width:'100%',position:'absolute',top:0,left:0,right:0,backgroundColor:'none',display:'flex',alignItems:'center',flexDirection:'row'}, this.props.style]}>
          <StatusBar barStyle="light-content" />
          <SafeAreaView forceInset={{top:'always'}} style={{zIndex:10,position:'relative',flex:1}}>
            <View style={{zIndex:10,flex:1,marginLeft:20,marginRight:20,display:'flex',alignItems:'center',flexDirection:'row'}}>
              {tabs}
            </View>
          </SafeAreaView>
          <TopGradient />
        </View>
      );
    }
}
