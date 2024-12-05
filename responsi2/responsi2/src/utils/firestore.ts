// src/utils/firestore.ts
import { auth, db } from "./firebase";
import {
    collection,
    addDoc,
    getDocs,
    doc,
    updateDoc,
    deleteDoc,
    query,
    orderBy,
    Timestamp
} from 'firebase/firestore';

// interface data
export interface Mainan {
    id?: string;
    nama: string;
    cerita: string;
    status: boolean;
    createdAt: Timestamp;
    updatedAt: Timestamp;
}

export const firestoreService = {
    // get collection ref for all users
    getGlobalMainanRef() {
        return collection(db, 'Mainans');
    },

    // create
    async addMainanGlobal(Mainan: Omit<Mainan, 'id'>) {
        try {
            const MainanRef = this.getGlobalMainanRef();
            const docRef = await addDoc(MainanRef, {
                ...Mainan,
                status: false,
                createdAt: Timestamp.now(),
                updatedAt: Timestamp.now()
            });
            return docRef.id;
        } catch (error) {
            console.error('Error Tambah Mainan:', error);
            throw error;
        }
    },

    async getGlobalMainans(): Promise<Mainan[]> {
        try {
            const MainanRef = this.getGlobalMainanRef();
            const q = query(MainanRef, orderBy('updatedAt', 'desc'));
            const snapshot = await getDocs(q);
            return snapshot.docs.map((doc) => ({
                id: doc.id,
                ...doc.data()
            } as Mainan));
        } catch (error) {
            console.error('Error Get Mainans:', error);
            throw error;
        }
    },

		// update
    async updateMainan(id: string, Mainan: Partial<Mainan>) {
        try {
            const MainanRef = this.getGlobalMainanRef();
            const docRef = doc(MainanRef, id);
            await updateDoc(docRef, {
                ...Mainan,
                updatedAt: Timestamp.now()
            });
        } catch (error) {
            console.error('Error Update Mainan:', error);
            throw error;
        }
    },

		// delete
    async deleteMainan(id: string) {
        try {
            const MainanRef = this.getGlobalMainanRef();
            const docRef = doc(MainanRef, id);
            await deleteDoc(docRef);
        } catch (error) {
            console.error('Error Delete Mainan:', error);
            throw error;
        }
    },

		// update status
    async updateStatus(id: string, status: boolean) {
        try {
            const MainanRef = this.getGlobalMainanRef();
            const docRef = doc(MainanRef, id);
            await updateDoc(docRef, { status: status, updatedAt: Timestamp.now() });
        } catch (error) {
            console.error('Error Update Status:', error);
            throw error;
        }
    }

}