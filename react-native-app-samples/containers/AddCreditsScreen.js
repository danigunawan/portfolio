import React from 'react';
import {NavigationActions} from 'react-navigation'
import {ActivityIndicator,AsyncStorage,Button,StatusBar,StyleSheet,View,Text,TouchableOpacity,Image} from 'react-native';
import STYLES from '../config/styles';
import SquidLoader from '../components/SquidLoader';
import SquidIcon from '../components/SquidIcon';
import FullWidthButton from '../components/FullWidthButton';
import BackgroundOverlay from '../components/BackgroundOverlay';
import Headline from '../components/Headline';
import Icon from '../components/Icon';
import {normalize} from '../config/utils';
import { connect } from 'react-redux';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: STYLES.COLORS.DOMINANT,
    color: 'white'
  },
  buttons: {display:'flex',width: '100%',alignSelf: 'stretch'},
});

class AddCreditsScreen extends React.Component {
  constructor() {
    super();
  }

  // Render any loading content that you like here
  render() {
    if (this.state.showAuth) {
      loader = null;
      display =
        (<View style={{display:'flex',width: '100%',alignSelf: 'stretch'}}>
          <FullWidthButton style={{height: 100}} onPress={() => this.props.navigation.navigate('SignIn')} label="Sign In"/>
          <FullWidthButton style={{height: 100,backgroundColor:STYLES.COLORS.SECONDARY}} onPress={() => this.props.navigation.navigate('SignUp')} label="Sign Up"/>
        </View>);
    } else {
      loader = (<ActivityIndicator/>);
      display = null;
    }

    return (
      <View style={{...styles.container,paddingTop:50,position:'relative'}}>
        <StatusBar barStyle="light-content" />
        <BackgroundOverlay />
        <Icon name="close" style={{fontSize:30,position:'absolute',left:20,top:50}}/>
        <View style={{flex:1,width:'100%',position:'relative',textAlign:'center',justifyContent:'center',alignItems:'center'}}>
          <SquidIcon style={{resizeMode:'contain',position:'relative',width:100,height:100,alignSelf:'center'}} source={require('../assets/images/squid.png')} />
          <Text allowFontScaling={false} style={{color:'white',marginTop:20,marginBottom:50,textAlign:'center',fontFamily:STYLES.FONT_FAMILY,fontSize:30,fontWeight:'900',letterSpacing:-1.5}}>You're all out of credits!</Text>
          <TouchableOpacity style={{backgroundColor:'rgba(255,255,255,.8)',width:'80%',borderRadius:10,marginBottom:20,padding:25}} onPress={()=>{}}>
            <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,color:'black',fontSize:22,textAlign:'center',fontWeight:'bold'}}>20 credits for $4</Text>
          </TouchableOpacity>
          <TouchableOpacity style={{backgroundColor:'rgba(255,255,255,.8)',width:'80%',borderRadius:10,marginBottom:20,padding:25}} onPress={()=>{}}>
            <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,color:'black',fontSize:22,textAlign:'center',fontWeight:'bold'}}>50 credits for $7</Text>
          </TouchableOpacity>
          <TouchableOpacity style={{backgroundColor:STYLES.COLORS.PRIMARY,width:'80%',borderRadius:10,marginBottom:20,padding:0,overflow:'hidden'}} onPress={()=>{}}>
            <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,color:'black',fontSize:22,backgroundColor:'white',borderRadius:10,overflow:'hidden',padding:25,textAlign:'center',fontWeight:'bold'}}>100 credits for $10</Text>
            <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,color:'white',fontSize:12,padding:3,textAlign:'center',fontWeight:'900'}}>Best Value</Text>
          </TouchableOpacity>
        </View>
        <FullWidthButton label="Add 100 credits"/>
      </View>
    );
  }
}


function mapStateToProps(state) {
  return {
    showAuth: AccountsSelectors.getRequiresAuth(state)
  };
}

export default connect(mapStateToProps)(AddCreditsScreen);
