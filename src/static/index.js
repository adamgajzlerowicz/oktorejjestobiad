// pull in desired CSS/SASS files
require('./styles/main.scss');
// var $ = jQuery = require('../../node_modules/jquery/dist/jquery.js');           // <--- remove if jQuery not needed
// require('../../node_modules/bootstrap-sass/assets/javascripts/bootstrap.js');   // <--- remove if Bootstrap's JS not needed
const Elm = require('../elm/Main');

const config = {
    apiKey: "AIzaSyA37dJRaGpYOTVb0SfGK7_atWtGNjqB67c",
    authDomain: "oktorejjestobiad.firebaseapp.com",
    databaseURL: "https://oktorejjestobiad.firebaseio.com",
    projectId: "oktorejjestobiad",
    storageBucket: "oktorejjestobiad.appspot.com",
    messagingSenderId: "913002641856"
};

firebase.initializeApp(config);
const database = firebase.database();
const provider = new firebase.auth.GoogleAuthProvider();
provider.addScope('https://www.googleapis.com/auth/plus.login');

// database.ref('oktorejjestobiad/' + Math.random().toString().split('.')[1]).set({
//     foo: 'bar'
// });

const dataSource = database.ref('oktorejjestobiad/');

dataSource.once('value').then((snapshot) => {
    console.log('received data');
    const flags = Object.assign({}, {
            currentTime: 0,
            lunchAt: snapshot.val().lunchAt,
            higherRoomOk: null,
            lowerRoomOk: null
        }
    );
    Elm.Main.embed(document.getElementById('main'), flags);
});

dataSource.on('value', (snapshot) => {
    console.log('data updated: ', snapshot.val());
});

// app.ports.check.subscribe(function(model) {
//    console.log(model);
// });

