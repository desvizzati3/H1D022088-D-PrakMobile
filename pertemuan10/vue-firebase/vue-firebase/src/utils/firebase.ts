// src/utils/firebase.ts
import { initializeApp } from "firebase/app";
import { getAuth, GoogleAuthProvider } from "firebase/auth";

const firebaseConfig = {
  apiKey: "AIzaSyCBtr1OQ5eIQfMz29huswEnRmeYPMUgMTc",
  authDomain: "vue-firebase-desva.firebaseapp.com",
  projectId: "vue-firebase-desva",
  storageBucket: "vue-firebase-desva.firebasestorage.app",
  messagingSenderId: "731011890696",
  appId: "1:731011890696:web:eabab8b4bc50e7cd7d1bbd",
};

const firebase = initializeApp(firebaseConfig);
const auth = getAuth(firebase);
const googleProvider = new GoogleAuthProvider();

export { auth, googleProvider };
