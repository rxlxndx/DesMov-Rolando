const admin = require("firebase-admin");

// Carga del archivo de credenciales del service account
const serviceAccount = require("./serviceAccountKey.json");

// Inicializar el SDK de Firebase Admin
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

// TODO: pega aquí el token FCM que te dio la app Flutter
const deviceToken =
  "cYWmSaRgSYG8IVqNuiy-AS:APA91bEIzL3F_0HXLVM8KlzZ60zejY9w1vtrBUj0UDEz4Fp5vXLcf76qaOak_ee4XR83MTv5Cqv1OtDozgc8UpUINdRg4P0ZNLEqj0bKAeA2KKxKeRWuG14";

async function sendPush() {
  const message = {
    token: deviceToken,
    notification: {
      title: "Hola desde Firebase Admin Rolandoooo",
      body: "Este es un mensaje enviado con la API v Rolandooo",
    },
    data: {
      origen: "node-demo",
      tipo: "prueba",
    },
  };

  try {
    const response = await admin.messaging().send(message);
    console.log("✅ Mensaje enviado correctamente:", response);
  } catch (error) {
    console.error("❌ Error al enviar mensaje:", error);
  }
}

sendPush();