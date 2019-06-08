import React from 'react';
import {NavigationActions} from 'react-navigation'
import {ActivityIndicator,AsyncStorage,Button,TextInput,ScrollView,StatusBar,StyleSheet,View,Text,TouchableOpacity,Image,SafeAreaView} from 'react-native';
import STYLES from '../config/styles';
import Search from '../components/Search';
import {normalize} from '../config/utils';
import { connect } from 'react-redux';

class SearchScreen extends React.Component {
  constructor() {
    super();
    this.state = {showAuth: false}
  }

  // Render any loading content that you like here
  render() {
    return (
      <View style={{flex:1}}>
        <Search />
      </View>
    );
  }
}

function mapStateToProps(state) {
  return {
    showAuth: AccountsSelectors.getRequiresAuth(state)
  };
}

export default connect(mapStateToProps)(SearchScreen);
