import React,{ Component } from 'react';
import { View, StatusBar,Text,TouchableOpacity,ScrollView,SafeAreaView,Modal } from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import STYLE from '../config/styles';
import {normalize} from '../config/utils';
import Icon from './Icon';
import ToggleButton from './ToggleButton';
import Search from './Search';

export default class SearchBar extends Component {
  state = {
    showSearch: false,
  };

  constructor(props) {
    super(props);
  }

  componentWillReceiveProps = (props) => {
    this.setState(props);
  }

  setShowModal = (visible) => {
    this.setState({showSearch: visible});
  }

  render() {
    return (
      <>
        <View style={[{width:'100%',position:'absolute',top:0,left:0,right:0,backgroundColor:'none',display:'flex',alignItems:'center',flexDirection:'row',zIndex:100}, this.props.style]}>
          <SafeAreaView style={{position:'relative'}} forceInset={{top:'always'}}>
            <StatusBar barStyle="light-content" />
            <ScrollView horizontal={true} showsHorizontalScrollIndicator={false} style={{zIndex:10,marginLeft:0,marginTop:10,marginBottom:10,marginRight:0,height:28}} contentContainerStyle={{paddingLeft:20,paddingRight:10}}>
              <TouchableOpacity onPress={()=>{this.setState({showSearch:true})}}>
                <Icon style={{marginTop:2,marginRight:5,padding:10,marginTop:-8,marginLeft:-10}} name="search"/>
              </TouchableOpacity>
              <ToggleButton style={{marginRight:10,backgroundColor:'rgba(255,255,255,.9)'}} labelStyle={{color:'black'}} label="Business"/>
              <ToggleButton style={{marginRight:10,backgroundColor:'rgba(255,255,255,.9)'}} labelStyle={{color:'black'}} label="Entrepreneurship"/>
              <ToggleButton style={{marginRight:10,backgroundColor:'rgba(255,255,255,.9)'}} labelStyle={{color:'black'}} label="Starups"/>
              <ToggleButton style={{marginRight:10,backgroundColor:'rgba(255,255,255,.9)'}} labelStyle={{color:'black'}} label="Culture"/>
            </ScrollView>
            <LinearGradient colors={['rgba(0,0,0,.9)', 'rgba(0,0,0,.85)', 'rgba(0,0,0,.6)', 'rgba(0,0,0,.05)']} style={{zIndex:1,position:'absolute',width:'100%',height:100,left:0,right:0,bottom:0}}/>
          </SafeAreaView>
        </View>
        <Modal animationType="fade" transparent={true} visible={this.state.showSearch} onRequestClose={() => { Alert.alert('Modal has been closed.'); }}>
          <Search cancelSearch={()=>{this.setState({showSearch:false})}}/>
        </Modal>
      </>
    );
  }
}
