import React from 'react';
import {ActivityIndicator,AsyncStorage,Button,StatusBar,StyleSheet,View} from 'react-native';
import PostList from '../components/PostList';
import {normalize} from '../config/utils';
import { connect } from 'react-redux';

class QueueScreen extends React.Component {
  static navigationOptions = {
    title: 'Welcome to the account screen!',
  };

  render() {
    return (
      <View style={{flex:1,backgroundColor:'black',display:'flex'}}>
        <PostList data={[{title:'first'},{title:'second'}]}/>
      </View>
    );
  }

  _showMoreApp = () => {
    this.props.navigation.navigate('Other');
  };

  _signOutAsync = async () => {
    await AsyncStorage.clear();
    this.props.navigation.navigate('Auth');
  };
}

function mapStateToProps(state) {
  return {
    showAuth: AccountsSelectors.getRequiresAuth(state)
  };
}

export default connect(mapStateToProps)(QueueScreen);
