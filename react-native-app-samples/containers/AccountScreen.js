import React from 'react';
import {ActivityIndicator,AsyncStorage,Button,StatusBar,StyleSheet,View,ScrollView,SafeAreaView} from 'react-native';
import firebase from 'react-native-firebase';
import {createStackNavigator,createSwitchNavigator} from 'react-navigation';
import TopGradient from '../components/TopGradient';
import TopNavButton from '../components/TopNavButton';
import FormInputWithLabel from '../components/FormInputWithLabel';
import FormLineWithAction from '../components/FormLineWithAction';
import FormLineWithLabel from '../components/FormLineWithLabel';
import FormSwitch from '../components/FormSwitch';
import FormButton from '../components/FormButton';
import FormLink from '../components/FormLink';
import FormHeader from '../components/FormHeader';
import FormChannelWithAction from '../components/FormChannelWithAction';
import {normalize} from '../config/utils';
import { connect } from 'react-redux';

class AccountScreen extends React.Component {
  state = { currentUser: null }

  componentDidMount() {
    const { currentUser } = firebase.auth();
    this.setState({ currentUser });
  }

  handleSignOut = async () => {
    try {
      await firebase.auth().signOut();
      this.props.navigation.navigate('Welcome');
    } catch (e) {
      console.log(e);
    }
  }

  render() {
    return (
      <View style={{backgroundColor:'black',flex:1,position:'relative'}}>
        <StatusBar barStyle="light-content" />
        <TopGradient style={{flex:1}}/>
        <SafeAreaView style={{flex:1}} forceInset={{top:'always'}}>
          <ScrollView contentContainerStyle={{backgroundColor:'transparent',paddingTop:0,paddingBottom:150,paddingLeft:20,paddingRight:20}}>
            <FormHeader label="Profile"/>
            <FormInputWithLabel label="First Name*" ref="" value={'John'}/>
            <FormInputWithLabel label="Last Name*" value={'Doe'}/>
            <FormInputWithLabel label="Email*" value={'john.doe@gmail.com'}/>
            <FormHeader label="Channels"/>
            <FormChannelWithAction />
            <FormChannelWithAction />
            <FormChannelWithAction />
            <FormHeader label="Notifications"/>
            <FormSwitch label="Empty Queue" description="Out of content alert" value={true}/>
            <FormSwitch label="RecommendedContent" description="New content you may like" value={false}/>
            <FormSwitch label="Connection Problems" description="Issues with your accounts" value={true}/>
            <FormSwitch label="Post Success" description="Each time we post" value={true}/>
            <FormHeader label="Transactions & Credits"/>
            <FormLineWithAction label="88 Credits Available" value="Buy More"/>
            <FormLineWithLabel label="100 Post Credits" description="4 days ago" value={'$10.00'}/>
            <FormLineWithLabel label="Post Purchase" description="4 days ago" value={'4 credits'}/>
            <FormLineWithLabel label="20 Post Credits" description="4 days ago" value={'$4.00'}/>
            <FormLink label="View All Transactions" onPress={()=>{}} style={{alignSelf:'center'}}/>
            <FormButton onPress={this.handleSignOut} label='Account Sign Out' style={{width:'100%',flex:1}}/>
          </ScrollView>
        </SafeAreaView>
      </View>
    );
  }
}

function mapStateToProps(state) {
  return {
    showAuth: AccountsSelectors.getRequiresAuth(state)
  };
}

export default connect(mapStateToProps)(AccountScreen);
