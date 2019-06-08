import React from 'react';
import {ActivityIndicator,AsyncStorage,Button,StatusBar,StyleSheet,View,ScrollView,Text,TouchableOpacity,Image,SafeAreaView,Modal} from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import STYLES from '../config/styles';
import Avatar from '../components/Avatar';
import Icon from '../components/Icon';
import SquidLoader from '../components/SquidLoader';
import SquidIcon from '../components/SquidIcon';
import FullWidthButton from '../components/FullWidthButton';
import ToggleButton from '../components/ToggleButton';
import TopNavButton from '../components/TopNavButton';
import TopGradient from '../components/TopGradient';
import Headline from '../components/Headline';
import Search from '../components/Search';
import {normalize} from '../config/utils';
import { connect } from 'react-redux';

class PostFormScreen extends React.Component {
  constructor(props) {
    super(props);
  }

  state = {
    showAccountSearch: false,
  };

  setShowAccountSearch(visible) {
    this.setState({showAccountSearch: visible});
  }

  render() {
    return (
      <View style={{flex:1,alignItems:'center',justifyContent:'center',backgroundColor:'black',color:'white'}}>
        <TopGradient style={{zIndex:1}}/>
        <SafeAreaView style={{position:'absolute',top:0,zIndex:20,width:'100%',alignItems:'center',justifyContent:'center'}} forceInset={{top:'always'}}>
          <View style={{zIndex:20,width:'100%',alignItems:'center',justifyContent:'center'}}>
            <TopNavButton style={{zIndex:20}} navigation={this.props.navigation} icon="close"/>
            <View style={{zIndex:20,position:'absolute',top:5,alignItems:'center',flexDirection:'row',justifyContent:'center',borderRadius:100,overflow:'hidden',backgroundColor:'rgba(0,0,0,.3)',borderWidth:2,borderColor:'rgba(255,255,255,1)'}}>
              <TouchableOpacity><View style={{backgroundColor:'white',paddingLeft:12,paddingRight:12,paddingTop:7,paddingBottom:6}}><Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,color:'black',fontWeight:'800',fontSize:12}}>Queue Post</Text></View></TouchableOpacity>
              <TouchableOpacity><View style={{backgroundColor:'transparent',paddingLeft:12,paddingRight:12,paddingTop:7,paddingBottom:6}}><Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,color:'white',fontWeight:'800',fontSize:12}}>Sell Post</Text></View></TouchableOpacity>
            </View>
          </View>
        </SafeAreaView>
        <View style={{flex:1,backgroundColor:'black',width:'100%',display:'flex'}}>
          <StatusBar barStyle="light-content" />
          <View style={{zIndex:1,flex:1}}>
            <Image style={{resizeMode:'cover',position:'absolute',width:'100%',height:'90%',opacity:1,top:0}} source={require('../assets/images/post-demo.jpg')}/>
            <LinearGradient colors={['rgba(0,0,0,0)','rgba(0,0,0,1)']} style={{zIndex:1,position:'absolute',width:'100%',height:100,bottom:'10%',right:0}}/>
          </View>
          <View style={{zIndex:2,position:'absolute',bottom:0,left:0,right:0,padding:0}}>
            <View style={{zIndex:2,flex:1,flexDirection:'row',paddingBottom:10,alignItems:'flex-end',paddingLeft:20,paddingRight:20}}>
              <View style={{flex:1,alignItems:'flex-start'}}>
                <View style={{width:40}}>
                  <Avatar source={require('../assets/images/author-demo.jpg')} />
                </View>
                <Text style={{...STYLES.PARAGRAPH,fontSize:14,marginTop:8,fontWeight:'700',color:'white'}} numberOfLines={1}>Nicole</Text>
              </View>
              <View style={{flex:1,alignItems:'flex-end'}}>
                <Text allowFontScaling={false} style={{...STYLES.LINK,fontSize:20,fontWeight:'900',marginBottom:5,textDecorationLine:'none',padding:0}} numberOfLines={1}>Sell Post?</Text>
                <Text allowFontScaling={false} style={{...STYLES.LINK,fontSize:14,textDecorationLine:'none',padding:0,marginTop:0}} numberOfLines={1} onPress={() => Linking.openURL('http://www.entrepreneur.com')}><Icon style={{height:10,width:10,position:'absolute'}} name="pencil"/>entrepreneur.com</Text>
              </View>
            </View>
            <View style={{zIndex:2,paddingLeft:20,paddingRight:20}}>
              <Text allowFontScaling={false} style={{color:'white',fontFamily:STYLES.FONT_FAMILY,fontSize:16,fontWeight:'700',letterSpacing:0}}>Add a post description.</Text>
              <Text allowFontScaling={false} style={{color:'white',fontFamily:STYLES.FONT_FAMILY,fontSize:16,fontWeight:'700',letterSpacing:0,paddingRight:35}}>In the season finale of Entrepreneur Elevator Pitch, the investors have never been so impressed.</Text>
              <View style={{padding:0,margin:0,position:'absolute',right:20,bottom:2,height:35}}><Icon style={{padding:10}} name="pencil"/></View>
            </View>
            <ScrollView horizontal={true} showsHorizontalScrollIndicator={false} style={{zIndex:2,width:'100%',height:45,marginTop:10,marginBottom:5,paddingLeft:20,paddingRight:20}}>
              <View style={{width:40,marginRight:15}}>
                <Avatar source={require('../assets/images/author-demo.jpg')} />
              </View>
              <View style={{width:40,marginRight:15}}>
                <Avatar source={require('../assets/images/author-demo.jpg')} />
              </View>
              <TouchableOpacity style={{width:200,flexDirection:'row'}} onPress={() => {this.setShowAccountSearch(true)}}>
                <View style={{width:45,height:45,backgroundColor:'white',borderRadius:50,alignItems:'center',justifyContent:'center'}}>
                  <Icon name="add" style={{marginTop:5,fontSize:18,color:'#333'}}/>
                </View>
                <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,fontSize:12,paddingLeft:10,fontWeight:'900',paddingTop:14}}>Add more accounts</Text>
              </TouchableOpacity>
            </ScrollView>
            <ScrollView horizontal={true} showsHorizontalScrollIndicator={false} style={{zIndex:2,width:'100%',height:20,marginTop:5,marginBottom:15}} contentContainerStyle={{paddingLeft:20,paddingRight:20}}>
              <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,fontSize:12,padding:0,margin:0,fontWeight:'900',marginRight:20}}>Posting to Pineapple Express Facebook Page, Pineapple Express Facebook Page, Pineapple Express Facebook Page and Pineapple Express Facebook Page</Text>
            </ScrollView>
            <LinearGradient colors={['rgba(0,0,0,0)', 'rgba(0,0,0,0.9)', 'rgba(0,0,0,0.9)','rgba(0,0,0,1)']} style={{zIndex:1,position:'absolute',width:'100%',height:'100%',bottom:0,right:0}}/>
          </View>
        </View>
        <Text allowFontScaling={false} style={{...STYLES.PARAGRAPH,width:'100%',fontSize:13,fontWeight:'900',color:'white',backgroundColor:'#333',padding:5,textAlign:'center'}}>Creating a post for your account is free</Text>
        <FullWidthButton style={{height:normalize(70)}} onPress={()=>{this.props.navigation.navigate('Browse')}} label="Add Post To Queue"/>
        <Modal animationType="fade" transparent={true} visible={this.state.showAccountSearch} onRequestClose={() => { Alert.alert('Modal has been closed.'); }}>
          <Search cancelSearch={()=>{this.setState({showAccountSearch:false})}}/>
        </Modal>
      </View>
    );
  }
}

function mapStateToProps(state) {
  return {
    showAuth: AccountsSelectors.getRequiresAuth(state)
  };
}

export default connect(mapStateToProps)(PostFormScreen);
