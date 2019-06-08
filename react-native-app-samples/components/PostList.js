import React from 'react';
import LinearGradient from 'react-native-linear-gradient';
import { TouchableWithoutFeedback,TouchableOpacity,Text,StatusBar,View,Image,Linking,FlatList,ScrollView } from 'react-native';
import Avatar from './Avatar';
import Icon from './Icon';
import STYLES from '../config/styles';
import {normalize} from '../config/utils';
import Post from './Post';

class MyListItem extends React.PureComponent {
  _onPress = () => {
    this.props.onPressItem(this.props.id);
  };

  render() {
    const textColor = this.props.selected ? "red" : "black";
    return (
      <TouchableWithoutFeedback style={{height:400,flex:1,display:'flex'}} onPress={this._onPress}>
        <View style={{height:400,flex:1,display:'flex'}}>
          <Post style={{flex:1}}/>
          <View style={{height:50,marginBottom:15,display:'flex',flexDirection:'row'}}>
            <ScrollView horizontal={true} showsHorizontalScrollIndicator={false} style={{zIndex:2,flex:2,height:45,paddingLeft:20,paddingRight:20}} contentContainerStyle={{justifyContent:'center',flexDirection:'row',display:'flex',paddingTop:5}}>
              <View style={{height:35,marginRight:10,flex:1,alignSelf:'center'}}>
                <Avatar source={require('../assets/images/author-demo.jpg')} />
              </View>
              <View style={{height:35,marginRight:10,flex:1,alignSelf:'center'}}>
                <Avatar source={require('../assets/images/author-demo.jpg')} />
              </View>
              <View style={{height:35,marginRight:10,flex:1,alignSelf:'center'}}>
                <Avatar source={require('../assets/images/author-demo.jpg')} />
              </View>
              <TouchableOpacity style={{paddingRight:50,flexDirection:'row',flex:1,alignSelf:'center'}} onPress={() => {this.setShowAccountSearch(true)}}>
                <View style={{width:35,height:35,backgroundColor:'white',borderRadius:50,alignItems:'center',justifyContent:'center'}}>
                  <Icon name="add" style={{marginTop:5,fontSize:18,color:'#333'}}/>
                </View>
              </TouchableOpacity>
            </ScrollView>
            <View style={{zIndex:10,paddingLeft:0,paddingRight:20,width:130,justifyContent:'center',flexDirection:'row',display:'flex'}}>
              <LinearGradient start={{x: 1.0, y: 0.0}} end={{x: 0.0, y: 0.0}} colors={['rgba(0,0,0,.8)', 'rgba(0,0,0,.55)', 'rgba(0,0,0,.3)', 'rgba(0,0,0,.0)']} style={{zIndex:1,position:'absolute',width:30,height:50,left:-30,bottom:0}}/>
              <Text style={{...STYLES.PARAGRAPH,flex:1,fontSize:12,opacity:.8,alignSelf:'center',textAlign:'right'}}>5 days from now</Text>
            </View>
          </View>
        </View>
      </TouchableWithoutFeedback>
    );
  }
}

export default class PostList extends React.Component {
  state = {selected: (new Map(): Map<string, boolean>)};

  _keyExtractor = (item, index) => item.id;

  _onPressItem = (id: string) => {
    // updater functions are preferred for transactional updates
    this.setState((state) => {
      // copy the map rather than modifying state.
      const selected = new Map(state.selected);
      selected.set(id, !selected.get(id)); // toggle
      return {selected};
    });
  };

  _renderItem = ({item}) => (
    <MyListItem
      id={item.id}
      onPressItem={this._onPressItem}
      selected={!!this.state.selected.get(item.id)}
      title={item.title}
    />
  );

  render() {
    return (
      <FlatList
        data={this.props.data}
        extraData={this.state}
        keyExtractor={this._keyExtractor}
        renderItem={this._renderItem}
        contentContainerStyle={{paddingBottom:100}}
      />
    );
  }
}
