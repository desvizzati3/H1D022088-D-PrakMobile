<template>
  <ion-page>
    <ion-header :translucent="true">
      <ion-toolbar>
        <ion-title>Mainan List</ion-title>
      </ion-toolbar>
    </ion-header>

    <ion-content :fullscreen="true">
      <ion-refresher
        slot="fixed"
        :pull-factor="0.5"
        :pull-min="100"
        :pull-max="200"
        @ionRefresh="handleRefresh($event)"
      >
        <ion-refresher-content></ion-refresher-content>
      </ion-refresher>

      <div class="scrollable-container">
        <ion-list>
          <ion-item-sliding
            v-for="Mainan in activeMainans"
            :key="Mainan.id"
            ref="setItemRef(Mainan.id)"
          >
            <ion-item>
              <div class="clickable-zone" @click="showMainanDetail(Mainan)">
                <ion-card class="full-width-card">
                  <ion-card-header>
                    <ion-card-title>{{ Mainan.nama }}</ion-card-title>
                    <ion-card-subtitle>{{
                      Mainan.cerita
                    }}</ion-card-subtitle>
                  </ion-card-header>
                  <ion-card-content>
                    <ion-badge color="primary">{{
                      getRelativeTime(Mainan.updatedAt)
                    }}</ion-badge>
                  </ion-card-content>
                </ion-card>
              </div>
            </ion-item>

            <!-- Slide Right to Edit -->
            <ion-item-options side="start">
              <ion-item-option color="primary" @click="handleEdit(Mainan)">
                <ion-icon :icon="create" slot="start"></ion-icon>
                Edit
              </ion-item-option>
            </ion-item-options>

            <!-- Slide Left to Delete -->
            <ion-item-options side="end">
              <ion-item-option color="danger" @click="confirmDelete(Mainan)">
                <ion-icon :icon="trash" slot="start"></ion-icon>
                Delete
              </ion-item-option>
            </ion-item-options>
          </ion-item-sliding>

          <ion-item v-if="activeMainans.length === 0" class="ion-text-center">
            <ion-label
              >There's nothing yet, start to add your own Mainan!</ion-label
            >
          </ion-item>
        </ion-list>

        <!-- Detail Modal -->
        <ion-modal
          :is-open="isDetailModalOpen"
          @didDismiss="isDetailModalOpen = false"
        >
          <ion-header>
            <ion-toolbar>
              <ion-title>{{ selectedMainan?.nama }}</ion-title>
              <ion-buttons slot="end">
                <ion-button @click="isDetailModalOpen = false">
                  <ion-icon :icon="close"></ion-icon>
                </ion-button>
              </ion-buttons>
            </ion-toolbar>
          </ion-header>
          <ion-content>
            <ion-card>
              <ion-card-header>
                <ion-card-title>{{ selectedMainan?.nama }}</ion-card-title>
                <ion-card-subtitle>{{
                  selectedMainan?.cerita
                }}</ion-card-subtitle>
              </ion-card-header>
              <ion-card-content>
                <p>
                  Last updated: {{ getRelativeTime(selectedMainan?.updatedAt) }}
                </p>
              </ion-card-content>
            </ion-card>
          </ion-content>
        </ion-modal>
      </div>

      <ion-fab vertical="bottom" horizontal="end" slot="fixed">
        <ion-fab-button @click="isOpen = true">
          <ion-icon :icon="add" size="large"></ion-icon>
        </ion-fab-button>
      </ion-fab>
      <InputModal
        v-model:isOpen="isOpen"
        v-model:editingId="editingId"
        :Mainan="Mainan"
        @submit="handleSubmit"
      />
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import {
  IonContent,
  IonHeader,
  IonPage,
  IonTitle,
  IonToolbar,
  IonItem,
  IonItemOption,
  IonItemOptions,
  IonItemSliding,
  IonCard,
  IonCardHeader,
  IonCardTitle,
  IonCardSubtitle,
  IonCardContent,
  IonBadge,
  IonIcon,
  IonFab,
  IonFabButton,
  IonAccordion,
  IonAccordionGroup,
  IonLabel,
  IonList,
  loadingController,
  IonRefresher,
  IonRefresherContent,
  toastController,
} from "@ionic/vue";
import {
  add,
  checkmarkCircle,
  close,
  create,
  trash,
  closeCircle,
  warningOutline,
} from "ionicons/icons";
import InputModal from "@/components/InputModal.vue";
import { onMounted, ref, computed, onUnmounted } from "vue";
import { firestoreService, type Mainan } from "@/utils/firestore";
import { formatDistanceToNow } from "date-fns";
import { alertController } from "@ionic/vue";
import { IonModal, IonButtons, IonButton } from "@ionic/vue";

const isDetailModalOpen = ref(false); // Controls modal visibility
const selectedMainan = ref<Mainan | null>(null); // Stores the selected Mainan

const showMainanDetail = (Mainan: Mainan) => {
  selectedMainan.value = Mainan;
  isDetailModalOpen.value = true;
};

const confirmDelete = async (Mainan: Mainan) => {
  const alert = await alertController.create({
    header: "Confirm Delete",
    message: `Are you sure you want to delete the Mainan ${Mainan.nama}?`,
    buttons: [
      {
        text: "Cancel",
        role: "cancel",
        handler: () => {
          console.log("Delete canceled");
        },
      },
      {
        text: "Delete",
        role: "destructive",
        handler: async () => {
          await handleDelete(Mainan);
        },
      },
    ],
  });
  await alert.present();
};

const isOpen = ref(false);
const editingId = ref<string | null>(null);
const Mainans = ref<Mainan[]>([]);
const Mainan = ref<Omit<Mainan, "id" | "createdAt" | "updatedAt" | "status">>({
  nama: "",
  cerita: "",
});
const activeMainans = computed(() =>
  Mainans.value.filter((Mainan) => !Mainan.status)
);
const completedMainans = computed(() =>
  Mainans.value.filter((Mainan) => Mainan.status)
);
const itemRefs = ref<Map<string, HTMLIonItemSlidingElement>>(new Map());
let intervalId: any;
const timeUpdateTrigger = ref(0);

// mendapatkan value dari item
const setItemRef = (el: any, id: string) => {
  if (el) {
    itemRefs.value.set(id, el.$el);
  }
};

// toast notifikasi
const showToast = async (
  message: string,
  color: string = "success",
  icon: string = checkmarkCircle
) => {
  const toast = await toastController.create({
    message,
    duration: 2000,
    color,
    position: "top",
    icon,
  });
  await toast.present();
};

// mendapatkan perbedaan waktu
const getRelativeTime = (date: any) => {
  timeUpdateTrigger.value;
  try {
    const jsDate = date?.toDate ? date.toDate() : new Date(date);
    return formatDistanceToNow(jsDate, { addSuffix: true });
  } catch (error) {
    return "Invalid date";
  }
};

const loadMainans = async (isLoading = true) => {
  let loading;
  if (isLoading) {
    loading = await loadingController.create({
      message: "Loading...",
    });
    await loading.present();
  }

  try {
    Mainans.value = await firestoreService.getGlobalMainans();
  } catch (error) {
    console.error(error);
  } finally {
    if (loading) {
      await loading.dismiss();
    }
  }
};

// dijalankan setiap halaman diload, load data dan set interval update 1 menit
onMounted(() => {
  loadMainans();
  intervalId = setInterval(() => {
    timeUpdateTrigger.value++;
  }, 60000);
});

// reset interval update
onUnmounted(() => {
  clearInterval(intervalId);
});

// handle swipe refresher
const handleRefresh = async (event: any) => {
  try {
    await loadMainans(false);
  } catch (error) {
    console.error("Error refreshing:", error);
  } finally {
    event.target.complete();
  }
};

// handle submit add/edit pada modal
const handleSubmit = async (
  Mainan: Omit<Mainan, "id" | "createdAt" | "updatedAt" | "status">
) => {
  if (!Mainan.nama) {
    await showToast("Title is required", "warning", warningOutline);
    return;
  }
  try {
    if (editingId.value) {
      await firestoreService.updateMainan(editingId.value, Mainan as Mainan);
      await showToast(
        "Mainan updated successfully",
        "success",
        checkmarkCircle
      );
    } else {
      await firestoreService.addMainanGlobal(Mainan as Mainan);
      await showToast("Mainan added successfully", "success", checkmarkCircle);
    }
    loadMainans();
  } catch (error) {
    await showToast("An error occurred", "danger", closeCircle);
    console.error(error);
  } finally {
    editingId.value = null;
  }
};

const handleEdit = async (editMainan: Mainan) => {
  const slidingItem = itemRefs.value.get(editMainan.id!);
  await slidingItem?.close();

  editingId.value = editMainan.id!;
  Mainan.value = {
    nama: editMainan.nama,
    cerita: editMainan.cerita,
  };
  isOpen.value = true;
};

// handle delete click/swipe
const handleDelete = async (deleteMainan: Mainan) => {
  try {
    await firestoreService.deleteMainan(deleteMainan.id!);
    await showToast("Mainan deleted successfully", "success", checkmarkCircle);
    loadMainans();
  } catch (error) {
    await showToast("Failed to delete Mainan", "danger", closeCircle);
    console.error(error);
  }
};

const handleStatus = async (statusMainan: Mainan) => {
  const slidingItem = itemRefs.value.get(statusMainan.id!);
  await slidingItem?.close();
  try {
    await firestoreService.updateStatus(statusMainan.id!, !statusMainan.status);
    await showToast(
      `Mainan marked as ${!statusMainan.status ? "completed" : "active"}`,
      "success",
      checkmarkCircle
    );
    loadMainans();
  } catch (error) {
    await showToast("Failed to update status", "danger", closeCircle);
    console.error(error);
  }
};
</script>

<!-- modifikasi src/views/HomePage.vue tambahkan keseluruhan style -->
<style scoped>
ion-accordion-group {
  width: 100%;
}

ion-card {
  margin: 16px;
  box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.2);
  border-radius: 8px;
}

ion-card-title {
  font-size: 1.2em;
  font-weight: bold;
  color: #000;
}

ion-card-subtitle {
  color: #666;
  font-size: 0.9em;
}

ion-badge {
  margin-top: 8px;
  font-size: 0.8em;
  padding: 6px;
  border-radius: 12px;
}

ion-fab {
  margin: 25px;
}

.limited-text {
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-box-orient: vertical;
}

ion-card-title.limited-text {
  -webkit-line-clamp: 1;
  line-clamp: 1;
}

ion-card-subtitle.limited-text {
  -webkit-line-clamp: 2;
  line-clamp: 2;
}

.full-width-card {
  width: 100%;
  margin: 0;
  box-shadow: none;
  border-radius: 0;
}

ion-item {
  --inner-padding-start: 0;
  --inner-padding-end: 0;
  --padding-start: 0;
}

.scrollable-container {
  max-height: 80vh;
  overflow-y: auto;
  overflow-x: hidden;
}

.accordion-container {
  --padding-start: 0;
  --inner-padding-end: 0;
}

ion-item {
  --padding-start: 0;
  --inner-padding-end: 0;
}

.scrollable-container::-webkit-scrollbar {
  width: 8px;
}

.scrollable-container::-webkit-scrollbar-track {
  background: #f1f1f1;
}

.scrollable-container::-webkit-scrollbar-thumb {
  background: #888;
  border-radius: 4px;
}

.scrollable-container::-webkit-scrollbar-thumb:hover {
  background: #555;
}
</style>
