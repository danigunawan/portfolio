import React from 'react';
import {ActivityIndicator,AsyncStorage,Button,StatusBar,StyleSheet,View,Text,SafeAreaView} from 'react-native';
import { createStackNavigator, createSwitchNavigator } from 'react-navigation';

import Post from '../components/Post';
import SearchBar from '../components/SearchBar';
import ConfirmationModal from '../components/ConfirmationModal';
import {normalize} from '../config/utils';
import { connect } from 'react-redux';

class BrowseScreen extends React.Component {
  render() {
    return (
      <View style={{flex: 1,alignItems: 'center',justifyContent: 'center',backgroundColor: 'black'}}>
        <Post style={{position:'relative',marginBottom:65}}/>
        <SearchBar />
        <ConfirmationModal showModal={false}>
          <Text allowFontScaling={false}>
            You rock! 100 Credits added to your account.
          </Text>
        </ConfirmationModal>
      </View>
    );
  }
}


function mapStateToProps(state) {
  return {
    showAuth: AccountsSelectors.getRequiresAuth(state)
  };
}

export default connect(mapStateToProps)(BrowseScreen);
