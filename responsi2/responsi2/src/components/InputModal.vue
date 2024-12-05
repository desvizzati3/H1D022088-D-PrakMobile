<!-- src/components/InputModal.vue -->
<template>
    <ion-modal :is-open="isOpen" @did-dismiss="cancel">
        <ion-header>
            <ion-toolbar>
                <ion-title>{{ editingId ? 'Edit' : 'Add' }} Mainan List</ion-title>
                <ion-buttons slot="start">
                    <ion-button @click="cancel"><ion-icon :icon="close"></ion-icon></ion-button>
                </ion-buttons>
            </ion-toolbar>
        </ion-header>
        <ion-content>
            <ion-item>
                <ion-input v-model="localMainan.nama" label="Nama Mainan" label-placement="floating"
                    placeholder="Masukan nama mainan Andy"></ion-input>
            </ion-item>
            <ion-item>
                <ion-textarea v-model="localMainan.cerita" label="Cerita Unik" label-placement="floating"
                    placeholder="Cerita unik mainan Andy" :autogrow="true" :rows="3"></ion-textarea>
            </ion-item>
            <ion-row>
                <ion-col>
                    <ion-button type="button" @click="input" shape="round" color="primary" expand="block">
                        {{ editingId ? 'Edit' : 'Add' }} Mainan
                    </ion-button>
                </ion-col>
            </ion-row>
        </ion-content>
    </ion-modal>
</template>
<script setup lang="ts">
import { IonModal, IonHeader, IonToolbar, IonTitle, IonButtons, IonButton, IonIcon, IonInput, IonRow, IonCol, IonItem, IonContent, IonTextarea } from '@ionic/vue';
import { close } from 'ionicons/icons';
import { Mainan } from '@/utils/firestore';
import { ref } from 'vue';
import { watch } from 'vue';

const props = defineProps<{
    isOpen: boolean,
    editingId: string | null,
    Mainan: Omit<Mainan, 'id' | 'createdAt' | 'updatedAt' | 'status'>
}>();

const emit = defineEmits<{
    'update:isOpen': [value: boolean],
    'update:editingId': [value: string | null],
    'submit': [item: Omit<Mainan, 'id' | 'createdAt' | 'updatedAt' | 'status'>]
}>();

const localMainan = ref({ ...props.Mainan });

const cancel = () => {
  emit('update:isOpen', false);
  emit('update:editingId', null);
  localMainan.value = { nama: '', cerita: '' };
};

const input = () => {
  emit('submit', localMainan.value);
  cancel();
};

watch(
  () => props.Mainan,
  (newMainan) => {
    localMainan.value = { ...newMainan };
  }
);

</script>