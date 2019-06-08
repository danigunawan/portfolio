import React,{ Component } from 'react';
import { View, StatusBar } from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import STYLE from '../config/styles';
import {normalize} from '../config/utils';

export default class TopGradient extends Component {
    render() {
      return (
        <View style={[{zIndex:1,height:70,width:'100%',position:'absolute',top:0,left:0,right:0,backgroundColor:'none',display:'flex',alignItems:'center',flexDirection:'row'}, this.props.style]}>
          <StatusBar barStyle="light-content" />
          <LinearGradient colors={['rgba(0,0,0,.9)', 'rgba(0,0,0,.85)', 'rgba(0,0,0,.6)', 'rgba(0,0,0,.05)']} style={{zIndex:1,position:'absolute',width:'100%',height:100,left:0,right:0,bottom:0}}/>
        </View>
      );
    }
}
