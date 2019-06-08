// https://reactnavigation.org/docs/en/navigating-without-navigation-prop.html
// NavigationService.js

// in any js module
// import NavigationService from 'path-to-NavigationService.js';
// NavigationService.navigate('ChatScreen', { userName: 'Lucy' });

import { NavigationActions } from 'react-navigation';

let _navigator;

function setTopLevelNavigator(navigatorRef) {
  _navigator = navigatorRef;
}

function navigate(routeName, params) {
  _navigator.dispatch(
    NavigationActions.navigate({
      routeName,
      params,
    })
  );
}

// add other navigation functions that you need and export them
export default {
  navigate,
  setTopLevelNavigator,
};
