import { createRouter, createWebHistory } from 'vue-router';
import FormPage from '../components/FormPage.vue';
import TasksPage from '../components/TasksPage.vue';

const routes = [
    { path: '/', component: FormPage },
    { path: '/tasks', component: TasksPage }
];

const index = createRouter({
    history: createWebHistory(),
    routes
});

export default index;