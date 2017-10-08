// pull in desired CSS/SASS files
require('./styles/main.scss');
// var $ = jQuery = require('../../node_modules/jquery/dist/jquery.js');           // <--- remove if jQuery not needed
// require('../../node_modules/bootstrap-sass/assets/javascripts/bootstrap.js');   // <--- remove if Bootstrap's JS not needed

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

firebase.auth().onAuthStateChanged(function(user) {
    if (user) {
        console.log('Is logged in');
        database.ref('dupa/' + Math.random().toString().split('.')[1]).set({
            foo: 'bar'
        });

        dataSource = database.ref('dupa/');

        dataSource.on('value', (snapshot) => {
            console.log('data updated: ', snapshot.val());
        })

        var Elm = require('../elm/Main');
        Elm.Main.embed(document.getElementById('main'));

    } else {
        firebase.auth().signInWithRedirect(provider);
    }
});