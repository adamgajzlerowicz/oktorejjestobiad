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

const app = Elm.Main.embed(document.getElementById('main'));

// database.ref('oktorejjestobiad/' + Math.random().toString().split('.')[1]).set({
//     foo: 'bar'
// });

const dataSource = database.ref('oktorejjestobiad/');

dataSource.once('value').then((snapshot) => {
    const flags = Object.assign({}, {
            currentTime: 0,
            lunchAt: snapshot.val().lunchAt,
            higherRoomOk: null,
            lowerRoomOk: null
        }
    );
    app.ports.apiData.send(flags);
});

dataSource.on('value', (snapshot) => {
    console.log('data updated: ', snapshot.val());
});



// app.ports.check.subscribe(function(model) {
//    console.log(model);
// });

