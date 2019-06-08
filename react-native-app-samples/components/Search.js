import React,{ Component } from 'react';
import { View, StatusBar,Text,TouchableOpacity,ScrollView,Modal,SafeAreaView,TextInput } from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import STYLE from '../config/styles';
import {normalize} from '../config/utils';
import Icon from './Icon';
import ToggleButton from './ToggleButton';
import FormLineWithAction from './FormLineWithAction';
import FormChannelWithAction from './FormChannelWithAction';
import FormLink from './FormLink';

export default class Search extends Component {
  state = {
    scope: 'all' // Must be one of: [all:default|users|posts|channels]
  }
  constructor(props) {
    super(props);
    if (props.scope) this.state.scope = props.scope;
  }

  updateSearchResult = (searchResult) => {
    this.setState({searchResult:searchResult});
  }

  render() {
    const backButton = (this.props.cancelSearch ? (<TouchableOpacity onPress={this.props.cancelSearch}><Icon style={{padding:10,marginLeft:-10,marginTop:-8}} name="navigateleft"/></TouchableOpacity>) : (<Icon style={{padding:10,marginLeft:-10,marginTop:-8}} name="search"/>));

    return (
      <View style={{flex:1}}>
        <SafeAreaView style={{...STYLES.MODAL}} forceInset={{top:'always'}}>
          <View style={{display:'flex',flexDirection:'row',paddingBottom:0,marginTop:10,marginLeft:20,marginRight:20,borderColor:'rgba(255,255,255,.8)',borderBottomWidth:1}}>
            {backButton}
            <TextInput allowFontScaling={false} autoFocus={true} placeholder="Keyword, Tag, or Person" autoCorrect={false} keyboardAppearance="dark" style={{flex:1,height:25,fontSize:18,color:'white'}} placeholderTextColor="rgba(255,255,255,.8)" onChangeText={(text) => this.setState({text})} value={this.state.text}/>
          </View>
          <ScrollView contentContainerStyle={{paddingTop:15,paddingLeft:20,paddingRight:20,paddingBottom:300}} showsVerticalScrollIndicator={false}>
            <FormLineWithAction label="Business" value="Add" style={{borderColor:'rgba(255,255,255,.5)'}}/>
            <FormChannelWithAction />
            <FormChannelWithAction />
            <FormChannelWithAction />
            <FormLink label="Connect More Channels" onPress={()=>{}} style={{alignSelf:'center'}} labelStyle={{padding:20,fontSize:18,fontWeight:'bold'}}/>
          </ScrollView>
        </SafeAreaView>
      </View>
    );
  }
}
