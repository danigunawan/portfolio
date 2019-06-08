// import React from 'react';
import {NavigationActions} from 'react-navigation'
import {ActivityIndicator,AsyncStorage,Button,StatusBar,StyleSheet,View,Text,TouchableOpacity,Image,TextInput,ScrollView} from 'react-native';
import STYLES from '../config/styles';
import {normalize} from '../config/utils';
import SquidLoader from '../components/SquidLoader';
import SquidIcon from '../components/SquidIcon';
import FullWidthButton from '../components/FullWidthButton';
import BackgroundOverlay from '../components/BackgroundOverlay';
import Headline from '../components/Headline';
import Icon from './Icon';
import ToggleButton from './ToggleButton';
import FormChannelWithAction from './FormChannelWithAction';
import FormLineWithAction from './FormLineWithAction';

import React, {Component} from 'react';
import {Modal, TouchableHighlight, Alert} from 'react-native';

import FontAwesomeIcon from 'react-native-vector-icons/FontAwesome';
import { Hideo } from 'react-native-textinput-effects';

export default class ConfirmationModal extends React.Component {
  constructor(props) {
    super(props);
    this.state = {showModal: props.showModal};
  }

  state = {
    showModal: false,
  };

  componentWillReceiveProps(props) {
    this.setState(props);
  }

  setShowModal(visible) {
    this.setState({showModal: visible});
  }

  render() {
    return (
      <Modal animationType="slide" transparent={true} visible={this.state.showModal} onRequestClose={() => { Alert.alert('Modal has been closed.'); }}>
        <View style={{...STYLES.MODAL,color:'white',alignItems:'center',justifyContent:'center',alignSelf:'center',position:'absolute',flexDirection:'row'}}>
          <StatusBar barStyle="light-content"/>
          <View style={{margin:20,borderRadius:STYLES.MODAL.BORDER_RADIUS,backgroundColor:STYLES.COLORS.DOMINANT,position:'relative',overflow:'hidden'}}>
            <View style={{padding:50,alignItems:'center',zIndex:1000}}>
              <SquidIcon style={{resizeMode:'contain',position:'relative',width:100,height:100}} source={require('../assets/images/squid.png')} />
              <Text allowFontScaling={false} style={{color:'white',fontFamily:STYLES.FONT_FAMILY,fontSize:22,marginTop:20,fontWeight:'900',letterSpacing:-1.5,alignItems:'center',textAlign:'center'}}>{this.props.children}</Text>
            </View>
            <BackgroundOverlay style={{height:300,zIndex:100,opacity:.5}}/>
          </View>
        </View>
      </Modal>
    );
  }
}
