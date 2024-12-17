<template>
  <div class="form-container">
    <form @submit.prevent="handleSubmit">
      <div class="form-group">
        <label for="name">Имя:</label>
        <input type="text" v-model="formData.name" id="name" />
        <span class="error">{{ errors.name }}</span>
      </div>
      <div class="form-group">
        <label for="surname">Фамилия:</label>
        <input type="text" v-model="formData.surname" id="surname" />
        <span class="error">{{ errors.surname }}</span>
      </div>
      <div class="form-group">
        <label for="age">Возраст:</label>
        <input type="number" v-model="formData.age" id="age" />
        <span class="error">{{ errors.age }}</span>
      </div>
      <div class="form-group">
        <label>Секс:</label>
        <div v-for="option in sexOptions" :key="option" class="radio-group">
          <input type="radio" v-model="formData.sex" :value="option" /> {{ option }}
        </div>
        <span class="error">{{ errors.sex }}</span>
      </div>
      <div class="form-group">
        <label>Фреймворки:</label>
        <div v-for="option in frameWorksOptions" :key="option" class="checkbox-group">
          <input type="checkbox" v-model="formData.frameworks" :value="option" /> {{ option }}
        </div>
        <span class="error">{{ errors.frameworks }}</span>
      </div>
      <button type="submit">Отправить</button>
      <div class="messages">
        <div v-if="successMessage">
          <p class="success">{{ successMessage }}</p>
        </div>
      </div>
    </form>
  </div>
</template>

<script>
import { ref, watch } from 'vue';

export default {
  name: 'FormPage',
  setup() {
    const formData = ref({
      name: "",
      surname: "",
      age: null,
      sex: "",
      frameworks: []
    });

    const sexOptions = Object.freeze({
      M: "M",
      F: "F"
    });

    const frameWorksOptions = Object.freeze({
      VUE: "Vue",
      ANGULAR: "Angular",
      SVELTE: "Svelte",
      REACT: "React"
    });

    const errors = ref({
      name: "",
      surname: "",
      age: "",
      sex: "",
      frameworks: ""
    });

    const successMessage = ref("");

    const validateField = (field) => {
      switch (field) {
        case 'name':
          errors.value.name = formData.value.name ? "" : "Имя обязательно";
          break;
        case 'surname':
          errors.value.surname = formData.value.surname ? "" : "Фамилия обязательна";
          break;
        case 'age':
          errors.value.age = formData.value.age && formData.value.age > 0 ? "" : "Возраст должен быть положительным числом";
          break;
        case 'sex':
          errors.value.sex = formData.value.sex ? "" : "Секс обязателен";
          break;
        case 'frameworks':
          errors.value.frameworks = formData.value.frameworks.length > 0 ? "" : "Необходимо выбрать хотя бы один фреймворк";
          break;
      }
    };

    watch(() => formData.value.name, () => validateField('name'));
    watch(() => formData.value.surname, () => validateField('surname'));
    watch(() => formData.value.age, () => validateField('age'));
    watch(() => formData.value.sex, () => validateField('sex'));
    watch(() => formData.value.frameworks, () => validateField('frameworks'), { deep: true });

    const handleSubmit = () => {
      ['name', 'surname', 'age', 'sex', 'frameworks'].forEach(field => validateField(field));
      if (!errors.value.name && !errors.value.surname && !errors.value.age && !errors.value.sex && !errors.value.frameworks) {
        successMessage.value = "Форма успешно отправлена!";
      } else {
        successMessage.value = "";
      }
    };

    return {
      formData,
      sexOptions,
      frameWorksOptions,
      errors,
      successMessage,
      validateField,
      handleSubmit
    };
  }
};
</script>

<style scoped>
.form-container {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  background: #fff;
  padding: 40px;
  margin: 10px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  width: 400px;
  box-sizing: border-box;
}

.form-group {
  margin-bottom: 15px;
  width: 100%;
}

label {
  display: block;
  font-weight: bold;
  margin-bottom: 5px;
}

input[type="text"],
input[type="number"],
input[type="radio"],
input[type="checkbox"] {
  width: 100%;
  padding: 10px;
  margin-bottom: 5px;
  border: 1px solid #ddd;
  border-radius: 4px;
}

input[type="radio"],
input[type="checkbox"] {
  width: auto;
  margin-right: 10px;
}

button {
  width: 100%;
  padding: 15px;
  background-color: #007BFF;
  border: none;
  border-radius: 4px;
  color: #fff;
  font-size: 16px;
  cursor: pointer;
}

button:hover {
  background-color: #0056b3;
}

span.error {
  color: red;
  font-size: 12px;
}

.success {
  color: green;
  font-weight: bold;
}

.messages {
  margin-top: 20px;
}
</style>
