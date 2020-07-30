const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.sendFollowerNotification = functions.database.ref('/notification/{notificationid}')
    .onWrite(async(change, context) => {
        var userNotification = change.after.val();
        let tokens;
        tokens = userNotification.tokens;
        console.log("all tokens " + tokens);
        const tokenArray = tokens.split(",");
        const payload = {
            notification: {
                title: userNotification.notificationType,
                body: userNotification.message,
                sound: "default",
                icon: ""
            }
        };
        console.log("notification sent to the following tokens " + tokenArray);
        return admin.messaging().sendToDevice(tokenArray, payload);
    });