<template>
  <div class="tasks-container">
    <h1>Задачки</h1>
    <input v-model="newTask" placeholder="Добавить таску" />
    <button @click="addNewTask">Добавить таску</button>
    <ul>
      <li v-for="task in tasks" :key="task.id" :class="{ completed: task.completed }">
        <span @click="toggleTask(task.id)">{{ task.text }}</span>
        <button @click="deleteTask(task.id)">Удалить</button>
      </li>
    </ul>
  </div>
</template>

<script>
import { ref, computed } from 'vue';
import { useStore } from 'vuex';

export default {
  name: 'TasksPage',
  setup() {
    const store = useStore();
    const newTask = ref('');
    const tasks = computed(() => store.getters.tasks);
    const addTask = () => store.dispatch('addTask', {
      id: Date.now(),
      text: newTask.value,
      completed: false
    });
    const toggleTask = (taskId) => store.dispatch('toggleTask', taskId);
    const deleteTask = (taskId) => store.dispatch('deleteTask', taskId);

    const addNewTask = () => {
      if (newTask.value.trim() !== '') {
        addTask();
        newTask.value = '';
      }
    };

    return {
      newTask,
      tasks,
      addNewTask,
      toggleTask,
      deleteTask
    };
  }
};
</script>

<style scoped>
.tasks-container {
  width: 100%;
  max-width: 600px;
  margin: 20px;
  padding: 20px;
  background: #f9f9f9;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  display: flex;
  flex-direction: column;
  height: calc(100vh - 120px);
  overflow-y: auto;
  box-sizing: border-box;
}

h1 {
  text-align: center;
}

input {
  width: 100%;
  padding: 10px;
  margin-bottom: 10px;
  border: 1px solid #ddd;
  border-radius: 4px;
  box-sizing: border-box;
}

button {
  padding: 10px;
  background-color: #007BFF;
  border: none;
  border-radius: 4px;
  color: white;
  cursor: pointer;
  margin-bottom: 10px;
}

ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

li {
  display: flex;
  justify-content: space-between;
  padding: 10px;
  border-bottom: 1px solid #ddd;
  box-sizing: border-box;
}

li.completed span {
  text-decoration: line-through;
  color: #999;
}

li button {
  background: none;
  border: none;
  color: #007BFF;
  cursor: pointer;
}

</style>
