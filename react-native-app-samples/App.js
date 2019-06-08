import React from 'react';
import {View,Button,Text,StatusBar} from 'react-native'
import {createBottomTabNavigator,createTabNavigator,createStackNavigator,createSwitchNavigator} from 'react-navigation';

import TabBar from './components/TabBar';
import TopTabBar from './components/TopTabBar';

import NavigationService from './services/NavigationService';

import AccountScreen from './containers/AccountScreen';
import AddCreditsScreen from './containers/AddCreditsScreen';
import BrowseScreen from './containers/BrowseScreen';
import ConfirmationScreen from './containers/ConfirmationScreen';
import ConnectAccountsScreen from './containers/ConnectAccountsScreen';
import FieldEditScreen from './containers/FieldEditScreen';
import PostedScreen from './containers/PostedScreen';
import PostFormScreen from './containers/PostFormScreen';
import QueueScreen from './containers/QueueScreen';
import SearchScreen from './containers/SearchScreen';
import SellingScreen from './containers/SellingScreen';
import SignInScreen from './containers/SignInScreen';
import SignUpScreen from './containers/SignUpScreen';
import WelcomeScreen from './containers/WelcomeScreen';

import './config/google';

const AppNavigator = createSwitchNavigator({
    AddCredits: AddCreditsScreen,
    Confirmation: ConfirmationScreen,
    ConnectAccounts: ConnectAccountsScreen,
    FieldEdit: FieldEditScreen,
    PostForm: PostFormScreen,
    SignIn: SignInScreen,
    SignUp: SignUpScreen,
    Welcome: WelcomeScreen,
    App: createBottomTabNavigator(
      {
        Browse: BrowseScreen,
        Search: SearchScreen,
        Posts: createTabNavigator({
          Queued: QueueScreen,
          Posted: PostedScreen,
          Selling: SellingScreen
        },{
          initialRouteName: 'Queued',
          tabBarComponent: (props => <TopTabBar {...props} navigation={props.navigation}/>)
        }),
        Account: AccountScreen
      },
      {
        initialRouteName: 'Browse',
        tabBarComponent: (props => <TabBar {...props} navigation={props.navigation}/>)
      }
    ),
  },
  {
    initialRouteName: 'Welcome',
    headerMode: 'none',
  }
);

export default class App extends React.Component {
  render() {
    return (
      <View style={{backgroundColor:'black',flex:1}}>
        <StatusBar barStyle="light-content" />
        <AppNavigator
          ref={navigatorRef => {
            NavigationService.setTopLevelNavigator(navigatorRef);
          }}
        />
      </View>
    );
  }
}
