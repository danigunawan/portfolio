import React from 'react';
import {ActivityIndicator,AsyncStorage,TouchableOpacity,TouchableWithoutFeedback,Keyboard,Button,SafeAreaView,StatusBar,StyleSheet,View,ScrollView,Text,Linking} from 'react-native';
import { createStackNavigator, createSwitchNavigator } from 'react-navigation';
import { AccessToken, LoginManager } from 'react-native-fbsdk';
import { GoogleSignin } from 'react-native-google-signin';
import firebase from 'react-native-firebase';
import FormInput from '../components/FormInput';
import Headline from '../components/Headline';
import FormSeperator from '../components/FormSeperator';
import FormButton from '../components/FormButton';
import FullWidthButton from '../components/FullWidthButton';
import TopNavButton from '../components/TopNavButton';
import STYLES from '../config/styles';
import BackgroundOverlay from '../components/BackgroundOverlay';
import { Input } from 'react-native-elements';
import SquidIcon from '../components/SquidIcon';
import {normalize} from '../config/utils';
import { connect } from 'react-redux';

class SignInScreen extends React.Component {
  state = { email: '', password: '', errorMessage: null }

  componentDidMount () {
    this.keyboardDidShowListener = Keyboard.addListener('keyboardDidShow', ()=>this.setState({keyboardOpen:true}));
    this.keyboardDidHideListener = Keyboard.addListener('keyboardDidHide', ()=>this.setState({keyboardOpen:false}));
  }

  componentWillUnmount () {
    this.keyboardDidShowListener.remove();
    this.keyboardDidHideListener.remove();
  }

  handleSignIn = () => {
    firebase
      .auth()
      .signInWithEmailAndPassword(this.state.email, this.state.password)
      .then(() => this.props.navigation.navigate('App'))
      .catch(error => this.setState({ errorMessage: error.message }))
  }

  handleFacebookSignIn = () => {
    LoginManager.logInWithReadPermissions(['public_profile', 'email'])
      .then((result) => {
        if (result.isCancelled) {
          return Promise.reject(new Error('The user cancelled the request'));
        }
        // Retrieve the access token
        return AccessToken.getCurrentAccessToken();
      })
      .then((data) => {
        // Create a new Firebase credential with the token
        const credential = firebase.auth.FacebookAuthProvider.credential(data.accessToken);
        // Login with the credential
        return firebase.auth().signInWithCredential(credential);
      })
      .then((user) => {
        // If you need to do anything with the user, do it here
        // The user will be logged in automatically by the
        // `onAuthStateChanged` listener we set up in App.js earlier
        this.props.navigation.navigate('App')
      })
      .catch((error) => {
        const { code, message } = error;
        // For details of error codes, see the docs
        // The message contains the default Firebase string
        // representation of the error
      });
  }

  handleGoogleSignIn = () => {
    GoogleSignin.signIn()
      .then((data) => {
        // Create a new Firebase credential with the token
        const credential = firebase.auth.GoogleAuthProvider.credential(data.idToken, data.accessToken);
        // Login with the credential
        return firebase.auth().signInWithCredential(credential);
      })
      .then((user) => {
        // If you need to do anything with the user, do it here
        // The user will be logged in automatically by the
        // `onAuthStateChanged` listener we set up in App.js earlier
        this.props.navigation.navigate('App')
      })
      .catch((error) => {
        const { code, message } = error;
        // For details of error codes, see the docs
        // The message contains the default Firebase string
        // representation of the error
      });
  }

  valid = (field) => {
    switch (field) {
      case 'email':
        return !!this.state.email;
      case 'password':
        return !!this.state.password;
      default:
        return true;
    }
  }

  validate = () => {
    this.setState({validate:true});
    return this.valid('email') && this.valid('password');
  }

  render() {
    return (
      <TouchableWithoutFeedback onPress={Keyboard.dismiss}>
        <View style={{flex:1,backgroundColor: STYLES.COLORS.DOMINANT}}>
          <BackgroundOverlay />
          <ScrollView contentContainerStyle={{paddingBottom:this.state.keyboardOpen ? 300 : 0,paddingTop:20,alignItems:'center',justifyContent:'center'}}>
            <StatusBar barStyle="light-content" />
            <SafeAreaView style={{flex:1,width:'100%',display:'flex',alignItems:'center',position:'relative'}}>
              <TopNavButton iconStyle={{zIndex:20,fontSize:24,top:10}} navigation={this.props.navigation} icon="navigateleft"/>
              <View style={{position:'relative',marginTop:10}}>
                <SquidIcon/>
              </View>
              <Headline text="Sign in to your account" style={{marginTop:0}}/>
              <FormInput label="Email" invalid={ this.state.validate && !this.valid('email') } autoCapitalize="none" onChangeText={email => this.setState({email})} value={this.state.email}/>
              <FormInput label="Password" invalid={ this.state.validate && !this.valid('password') } autoCapitalize="none" onChangeText={password => this.setState({password})} value={this.state.password} secureTextEntry={true}/>
              <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,color:'indianred',fontWeight:'bold',fontSize:14,textAlign:'center',marginBottom:20,display:this.state.errorMessage ? 'flex' : 'none'}}>{this.state.errorMessage}</Text>
              <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,paddingLeft:30,paddingRight:30,fontSize:10,textAlign:'center',fontFamily:STYLES.FONT_FAMILY}}>
                <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,fontSize:10}}>By tapping Sign In, you acknowledge that you have read and agree to our </Text>
                <Text allowFontScaling={false} style={{...STYLES.LINK,fontSize:10}} onPress={() => Linking.openURL('http://www.crowdsquid.com/privacy')}>Privacy Policy</Text>
                <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,fontSize:10}}> and </Text>
                <Text allowFontScaling={false} style={{...STYLES.LINK,fontSize:10}} onPress={() => Linking.openURL('http://www.crowdsquid.com/terms')}>Terms of Service</Text>
                <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,fontSize:10}}>.</Text>
              </Text>
              <FormSeperator label="OR"/>
              <FormButton style={{backgroundColor:STYLES.COLORS.GOOGLE_RED,marginBottom:20}} onPress={this.handleGoogleSignIn} label="Log In With Google"/>
              <FormButton style={{backgroundColor:STYLES.COLORS.FACEBOOK_BLUE,marginBottom:20}} onPress={this.handleFacebookSignIn} label="Log In With Facebook"/>
            </SafeAreaView>
          </ScrollView>
          <FullWidthButton style={{height: normalize(70)}} onPress={() => {this.validate() && this.handleSignIn()}} label="Sign In"/>
        </View>
      </TouchableWithoutFeedback>
    );
  }
}

function mapStateToProps(state) {
  return {
    showAuth: AccountsSelectors.getRequiresAuth(state)
  };
}

export default connect(mapStateToProps)(SignInScreen);
