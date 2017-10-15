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

const dataSource = database.ref('oktorejjestobiad/');

dataSource.on('value', function (snapshot) {
    app.ports.apiData.send(Object.assign({}, {
            higherRoomOk: null,
            lowerRoomOk: null
        }, snapshot.val()
    ));
});


app.ports.updateApi.subscribe(function (model) {
    console.log(model);
    database.ref('oktorejjestobiad/').set(model);
});

