import React from 'react';
import {NavigationActions} from 'react-navigation'
import {ScrollView,ActivityIndicator,AsyncStorage,Button,StatusBar,StyleSheet,View,Text,TouchableOpacity,Image} from 'react-native';
import STYLES from '../config/styles';
import SquidLoader from '../components/SquidLoader';
import SquidIcon from '../components/SquidIcon';
import FullWidthButton from '../components/FullWidthButton';
import BackgroundOverlay from '../components/BackgroundOverlay';
import Icon from '../components/Icon';
import Headline from '../components/Headline';
import ConnectNetworkButton from '../components/ConnectNetworkButton';
import {normalize} from '../config/utils';
import { connect } from 'react-redux';

class ConnectAccountsScreen extends React.Component {
  constructor() {
    super();
    this.state = {showAuth: false}
  }

  render() {
    return (
      <View style={{flex:1,backgroundColor:'black',paddingTop:50,position:'relative'}}>
        <StatusBar barStyle="light-content" />
        <BackgroundOverlay />
        <Icon name="close" style={{fontSize:30,position:'absolute',left:20,top:50}}/>
        <View style={{flex:1,width:'100%',position:'relative',textAlign:'center',justifyContent:'center',alignItems:'center',paddingLeft:20,paddingRight:20}}>
          <SquidIcon style={{resizeMode:'contain',position:'relative',width:100,height:100,alignSelf:'center'}} source={require('../assets/images/squid.png')} />
          <Text allowFontScaling={false} style={{color:'white',marginTop:20,marginBottom:20,textAlign:'center',fontFamily:STYLES.FONT_FAMILY,fontSize:25,width:'80%',fontWeight:'900',letterSpacing:-1.5}}>Connect an account to start posting!</Text>
          <ConnectNetworkButton network='facebook' style={{marginBottom:20}}/>
          <ConnectNetworkButton network='instagram' style={{marginBottom:20}}/>
          <ConnectNetworkButton network='twitter' style={{marginBottom:20}}/>
          <ConnectNetworkButton network='youtube' style={{marginBottom:20}}/>
          <ConnectNetworkButton network='linkedin' style={{marginBottom:20}}/>
        </View>
        <FullWidthButton onPress={()=>this.props.navigation.navigate('Browse')} label="Skip For Now"/>
      </View>
    );
  }
}

function mapStateToProps(state) {
  return {
    showAuth: AccountsSelectors.getRequiresAuth(state)
  };
}

export default connect(mapStateToProps)(ConnectAccountsScreen);
