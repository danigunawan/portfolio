import React from 'react';
import {NavigationActions} from 'react-navigation'
import {ActivityIndicator,AsyncStorage,Button,StatusBar,StyleSheet,View,Text,TouchableOpacity,Image} from 'react-native';
import STYLES from '../config/styles';
import SquidLoader from '../components/SquidLoader';
import SquidIcon from '../components/SquidIcon';
import FullWidthButton from '../components/FullWidthButton';
import BackgroundOverlay from '../components/BackgroundOverlay';
import Headline from '../components/Headline';
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

class ConfirmationScreen extends React.Component {
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
      <View style={styles.container}>
        <StatusBar barStyle="light-content" />
        <View style={styles.container}>
          <BackgroundOverlay />
          <Button title="Back" onPress={() => this.props.navigation.navigate(this.props.navigation.state.params.lastRouteName)}/>
          <SquidIcon style={{resizeMode:'contain',position:'relative',width:100,height:100}} source={require('../assets/images/squid.png')} />
          <Text allowFontScaling={false} style={{color:'white',fontFamily:STYLES.FONT_FAMILY,fontSize:40,fontWeight:'900',letterSpacing:-1.5}}>Connect</Text>
        </View>
        { loader }
        <Headline text="Unleash your content!" style={{marginBottom:150,marginTop:50}}/>
        { display }
      </View>
    );
  }
}

function mapStateToProps(state) {
  return {
    showAuth: AccountsSelectors.getRequiresAuth(state)
  };
}

export default connect(mapStateToProps)(ConfirmationScreen);
