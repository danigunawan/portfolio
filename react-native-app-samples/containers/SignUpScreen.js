import React from 'react';
import {ActivityIndicator,AsyncStorage,TouchableOpacity,SafeAreaView,TouchableWithoutFeedback,Button,StatusBar,StyleSheet,View,ScrollView,Text,Linking,Keyboard} from 'react-native';
import { createStackNavigator, createSwitchNavigator } from 'react-navigation';
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

class SignUpScreen extends React.Component {
  state = { step: 1, email: '', password: '', errorMessage: null }

  componentDidMount () {
    this.keyboardDidShowListener = Keyboard.addListener('keyboardDidShow', ()=>this.setState({keyboardOpen:true}));
    this.keyboardDidHideListener = Keyboard.addListener('keyboardDidHide', ()=>this.setState({keyboardOpen:false}));
  }

  componentWillUnmount () {
    this.keyboardDidShowListener.remove();
    this.keyboardDidHideListener.remove();
  }

  handleSignUp = () => {
    firebase
      .auth()
      .createUserWithEmailAndPassword(this.state.email, this.state.password)
      .then(() => this.props.navigation.navigate('ConnectAccounts'))
      .catch(error => this.setState({ errorMessage: error.message }))
  }

  validate = () => {
    this.setState({validate:true});
    if (this.state.step == 1)
      return this.props.validFirstName && this.props.validLastName;
    return this.props.validEmail && this.props.validPassword && this.props.validConfirmPassword;
  }

  render() {
    if (this.state.step == 2) {
      action = (<FullWidthButton style={{height: normalize(70)}} onPress={() => {this.validate() && this.handleSignUp()}} label="Activate Account"/>);
      form = (<>
          <TopNavButton style={{zIndex:20}} iconStyle={{zIndex:20,fontSize:24}} onPress={()=>{this.setState({step:1}) && Keyboard.dismiss()}} icon="navigateleft"/>
          <View style={{width:'100%',alignItems:'center',flex:1,alignSelf:'center',position:'relative'}}>
            <SquidIcon/>
            <Headline text="Set your email & password" style={{marginTop:0}}/>
            <FormInput label="Email" autoFocus={true} invalid={ this.state.validate && !this.valid('email') } autoCapitalize="none" onChangeText={email => this.setState({email})} value={this.state.email}/>
            <FormInput label="Password" valid={this.valid('confirmPassword')} invalid={ this.state.validate && !this.valid('password') } autoCapitalize="none" onChangeText={password => this.setState({password})} value={this.state.password} secureTextEntry={true}/>
            <FormInput label="Confirm Password" valid={this.valid('confirmPassword')} invalid={ this.state.validate && !this.valid('confirmPassword') } autoCapitalize="none" onChangeText={confirmPassword => this.setState({confirmPassword})} value={this.state.confirmPassword} secureTextEntry={true}/>
            <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,color:'indianred',fontWeight:'bold',fontSize:14,textAlign:'center',marginBottom:20,display:this.state.errorMessage ? 'flex' : 'none'}}>{this.state.errorMessage}</Text>
            <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,paddingLeft:30,paddingRight:30,fontSize:14,textAlign:'center',marginBottom:50,fontFamily:STYLES.FONT_FAMILY}}>
              <Text allowFontScaling={false} style={STYLES.PARAGRAPH}>By tapping Activate Account, you acknowledge that you have read our </Text>
              <Text allowFontScaling={false} style={STYLES.LINK} onPress={() => Linking.openURL('http://www.crowdsquid.com/privacy')}>Privacy Policy</Text>
              <Text allowFontScaling={false} style={STYLES.PARAGRAPH}> and agree to the </Text>
              <Text allowFontScaling={false} style={STYLES.LINK} onPress={() => Linking.openURL('http://www.crowdsquid.com/terms')}>Terms of Service</Text>
              <Text allowFontScaling={false} style={STYLES.PARAGRAPH}>.</Text>
            </Text>
          </View>
        </>)

      } else {
        action = (<FullWidthButton style={{height: normalize(70)}} onPress={() => {this.validate() && this.setState({step:2,validate:false}) && Keyboard.dismiss()}} label="Sign Up & Accept"/>);
        form = (<>
          <TopNavButton style={{zIndex:20}} iconStyle={{zIndex:20,fontSize:24}} navigation={this.props.navigation} icon="navigateleft"/>
          <View style={{width:'100%',alignItems:'center',flex:1,alignSelf:'center',position:'relative'}}>
            <SquidIcon/>
            <Headline text="Sign up for an account" style={{marginTop:0}}/>
            <FormInput invalid={ this.state.validate && !this.valid('firstName') } onChangeText={firstName => this.setState({firstName})} value={this.state.firstName} label="First Name"/>
            <FormInput invalid={ this.state.validate && !this.valid('lastName') } onChangeText={lastName => this.setState({lastName})} value={this.state.lastName} label="Last Name"/>
            <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,paddingLeft:30,paddingRight:30,fontSize:10,textAlign:'center',fontFamily:STYLES.FONT_FAMILY}}>
              <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,fontSize:10}}>By tapping Sign Up, you acknowledge that you have read and agree to our </Text>
              <Text allowFontScaling={false} style={{...STYLES.LINK,fontSize:10}} onPress={() => Linking.openURL('http://www.crowdsquid.com/privacy')}>Privacy Policy</Text>
              <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,fontSize:10}}> and </Text>
              <Text allowFontScaling={false} style={{...STYLES.LINK,fontSize:10}} onPress={() => Linking.openURL('http://www.crowdsquid.com/terms')}>Terms of Service</Text>
              <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,fontSize:10}}>.</Text>
            </Text>
            <FormSeperator label="OR"/>
            <FormButton style={{backgroundColor:STYLES.COLORS.GOOGLE_RED,marginBottom:20}} label="Sign Up With Google"/>
            <FormButton style={{backgroundColor:STYLES.COLORS.FACEBOOK_BLUE,marginBottom:20}} label="Sign Up With Facebook"/>
          </View>
        </>);
      }
    return (
      <TouchableWithoutFeedback onPress={Keyboard.dismiss}>
        <View style={{flex:1}}>
          <SafeAreaView style={{flex:1,backgroundColor:STYLES.COLORS.DOMINANT}}>
            <StatusBar barStyle="light-content" />
            <BackgroundOverlay />
            <ScrollView contentContainerStyle={{paddingBottom:this.state.keyboardOpen ? 300 : 0,paddingTop:0,alignItems:'center',justifyContent:'center',flexDirection:'row',display:'flex',flex:1}}>
              { form }
            </ScrollView>
          </SafeAreaView>
          { action }
        </View>
      </TouchableWithoutFeedback>
    );
  }
}

function mapStateToProps(state) {
  return {
    showAuth: AccountsSelectors.getRequiresAuth(state),
    validFirstName: AccountsSelectors.isSignUpValid(state, 'firstName'),
    validLastName: AccountsSelectors.isSignUpValid(state, 'lastName'),
    validEmail: AccountsSelectors.isSignUpValid(state, 'email'),
    validPassword: AccountsSelectors.isSignUpValid(state, 'password'),
    validConfirmPassword: AccountsSelectors.isSignUpValid(state, 'confirmPassword'),
  };
}

export default connect(mapStateToProps)(SignUpScreen);
