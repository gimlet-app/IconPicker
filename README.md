# Icon Picker
Use the FontAwesome Icons (FontAwesome v5.8.2) in your HTML forms.


### Current Version
1.0.0 [*](https://github.com/furcan/IconPicker/blob/master/ReleaseNotes.md)

### Website and Demo
https://furcan.github.io/IconPicker/


---------

#### Install

##### [npm](https://www.npmjs.com/package/@furcan/iconpicker)
```
npm i @furcan/iconpicker
```
##### [yarn](https://yarnpkg.com/en/package/@furcan/iconpicker)
```
yarn add @furcan/iconpicker
```

---------

#### 1- CSS
`<link rel="stylesheet" href="dist/fontawesome582/css/all.min.css" />`
`<link rel="stylesheet" href="dist/iconpicker-1.0.0.css" />`

#### 2- JavaScript
`<script src="dist/iconpicker-1.0.0.js"></script>`

#### 3- HTML
`<button type="button" id="GetIconPicker" data-iconpicker-input="input#IconInput" data-iconpicker-preview="i#IconPreview">Select Icon</button>`

--_--_--

#### 4- Init

```js
// Default options
IconPicker.Init({
  // Required: You have to set the path of IconPicker JSON file to "jsonUrl" option. e.g. '/content/plugins/IconPicker/dist/iconpicker-1.0.0.json'
  jsonUrl: null,
  // Optional: Change the buttons text according to the language.
  searchPlaceholder: 'Search Icon',
  showAllButton: 'Show All',
  cancelButton: 'Cancel',
});
```

--_--_--

#### 5- Run

```js
// Select your Button element (ID or Class)
IconPicker.Run('#GetIconPicker');
```


---------
---------
---------

#### Copyright
Copyright © 2019 Icon Picker

#### License
MIT license - https://opensource.org/licenses/MIT