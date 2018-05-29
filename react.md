# Mastering React

## Links
- [React](https://reactjs.org)
- [Browserify](http://browserify.org)
- [BabelJS](http://babeljs.io)

## Start project
```
$ npm init
$ npm install --save react react-dom
$ npm install -g browserify
$ npm install --save-dev babelify
$ npm install --save-dev babel-cli
```
- browserify is one of the many(webpack can be used as well) build systems that is being used on top of babel to futher convert require statements into actual js code executable in a browser
- install react specific presets (changes have been introduced in [Babel6](https://babeljs.io/blog/2015/10/29/6.0.0))

- use babel-preset-env instead of babel-preset-es2015, as it has been deprecated
```
$ npm install --save-dev babel-preset-react babel-preset-env
```

- create .babelrc
```json
{
   "presets" : ["env", "react"]
}
```

- add build command to package.json
```
"scripts": {
  ...
  "build": "browserify src/main.js -t babelify --outfile public/bundle.js"
  ...
}
```

- build the project
```
$ npm run build
```

- Code that used 
```
import React from 'react';
...
React.DOM.h1(null, "blah");
```
has been deprecated.

- do this instead
```
$ npm i --save react-dom-factories
```

- and then you can say
```
import DOM from 'react-dom-factories';
...
DOM.h1(null, "blah");
```
- [react elements](https://reactjs.org/docs/rendering-elements.html)

- install node sass
```
$ npm i --save-dev node-sass
```
- from the documentation about keys:
```
Keys help React identify which items have changed, are added, or are removed. 
Keys should be given to the elements inside the array to give the elements a stable identity. 
Keys used within arrays should be unique among their siblings. 
However they don't need to be globally unique. Keys serve as a hint to React 
but they don't get passed to your components. 
If you need the same value in your component, 
pass it explicitly as a prop with a different name.
```


