import React from 'react';
import {ActivityIndicator,AsyncStorage,Button,StatusBar,StyleSheet,View,Text,TouchableOpacity,Image} from 'react-native';
import firebase from 'react-native-firebase';
import STYLES from '../config/styles';
import autoBind from 'react-autobind';
import SquidLoader from '../components/SquidLoader';
import SquidIcon from '../components/SquidIcon';
import FullWidthButton from '../components/FullWidthButton';
import BackgroundOverlay from '../components/BackgroundOverlay';
import Headline from '../components/Headline';
import {normalize} from '../config/utils';
import { connect } from 'react-redux';
import { selectors as accountsSelectors, actions as accountsActions, types as accountsTypes } from '../store/accounts';

class WelcomeScreen extends React.Component {

  constructor(props) {
    super(props);
    autoBind(this);
  }

  componentWillMount() {
    this.props.dispatch(accountsActions.fetchCurrentAccount());
  }

  // Render any loading content that you like here
  render() {
    if (this.props.showAuth) {
      loader = null;
      display =
        (<View style={{display:'flex',width: '100%',alignSelf: 'stretch'}}>
          <FullWidthButton style={{height: normalize(70)}} onPress={() => this.props.navigation.navigate('SignIn',{lastRouteName:this.props.navigation.state.routeName})} label="Sign In"/>
          <FullWidthButton style={{height: normalize(70),backgroundColor:STYLES.COLORS.SECONDARY}} onPress={() => this.props.navigation.navigate('SignUp',{lastRouteName:this.props.navigation.state.routeName})} label="Sign Up"/>
        </View>);
    } else {
      loader = (<ActivityIndicator/>);
      display = null;
    }

    return (
      <View style={{flex: 1,alignItems: 'center',justifyContent: 'center',backgroundColor: STYLES.COLORS.DOMINANT,color: 'white'}}>
        <StatusBar barStyle="light-content" />
        <View style={{flex: 1,alignItems: 'center',justifyContent: 'center',backgroundColor: STYLES.COLORS.DOMINANT,color: 'white'}}>
          <BackgroundOverlay />
          <SquidIcon style={{resizeMode:'contain',position:'relative',width:normalize(100),height:normalize(100)}}/>
          <Text allowFontScaling={false} style={{color:'white',fontFamily:STYLES.FONT_FAMILY,fontSize:normalize(40),fontWeight:'900',letterSpacing:-1.5}}>crowdsquid</Text>
        </View>
        { loader }
        <Headline text="Unleash your content!" style={{marginBottom:normalize(20),marginTop:normalize(50)}}/>
        { display }
      </View>
    );
  }
}

function mapStateToProps(state) {
  return {
    showAuth: accountsSelectors.getAuthLoaded(state)
  };
}

export default connect(mapStateToProps)(WelcomeScreen);
