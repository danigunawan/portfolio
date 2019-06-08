import {normalize} from './utils';

STYLES = {
  FONT_FAMILY: 'Avenir',
  ICON_FONT_FAMILY: 'SS Standard',
  BORDER_RADIUS: normalize(10),
  BOX_SHADOW: '8',
}

STYLES.COLORS = {
  DOMINANT: '#FFCD00',
  PRIMARY: '#4A90E2',
  SECONDARY: '#F8001E',
  GOOGLE_RED: '#dd4b39',
  FACEBOOK_BLUE: '#3B5998'
};

STYLES.PARAGRAPH = {
  fontFamily: STYLES.FONT_FAMILY,
  fontWeight: '500',
  fontSize: normalize(11),
  color: 'white'
};

STYLES.LINK = {
  ...STYLES.PARAGRAPH,
  textDecorationLine:'underline',
  padding:2
};

STYLES.MODAL = {
  position:'absolute',
  top:0,
  bottom:0,
  left:0,
  right:0,
  backgroundColor:'rgba(0,0,0,.85)',
  zIndex:99999999
};

export default STYLES;
