<template>
    <q-card>
      <q-card-section>
        <q-form ref="form" @submit="onSubmit">
          <q-editor style="height: 80dvh" v-model="content" />
        </q-form>
      </q-card-section>
      <q-card-actions align="around">
        <q-btn color="secondary" @click="emit('cancel')"> Cancel </q-btn>
        <q-btn color="primary" @click="validateForm"> Validate </q-btn>
      </q-card-actions>
    </q-card>
  </template>
  
  <script setup lang="ts">
  import { QForm } from 'quasar';
  import { onMounted, ref, type PropType } from 'vue';
  
  const content = ref<string>('');
  
  const props = defineProps({
    field_label: {
      type: String as PropType<string>,
      default: 'Field Title',
      validator(value: string) {
        return value.length < 50;
      },
    },
    initial_content: {
      type: String as PropType<string>,
      default: '',
    },
    file_upload: {
      type: Function,
    },
  });
  
  onMounted(() => {
    content.value = props.initial_content ?? 'This is a test';
  });
  const emit = defineEmits<{
    (e: 'formValidated', value: string): void;
    (e: 'cancel'): void;
  }>();
  
  const form = ref<QForm | null>(null);
  
  const onSubmit = () => {
    emit('formValidated', content.value);
    return true;
  };
  
  const validateForm = () => {
    if (form.value) {
      form.value.submit();
    }
  };
  </script>
  
  <style scoped></style>
  