import { createStore } from 'vuex';

export default createStore({
    state: {
        tasks: []
    },
    mutations: {
        ADD_TASK(state, task) {
            state.tasks.push(task);
        },
        TOGGLE_TASK(state, taskId) {
            const task = state.tasks.find(task => task.id === taskId);
            if (task) {
                task.completed = !task.completed;
            }
        },
        DELETE_TASK(state, taskId) {
            state.tasks = state.tasks.filter(task => task.id !== taskId);
        }
    },
    actions: {
        addTask({ commit }, task) {
            commit('ADD_TASK', task);
        },
        toggleTask({ commit }, taskId) {
            commit('TOGGLE_TASK', taskId);
        },
        deleteTask({ commit }, taskId) {
            commit('DELETE_TASK', taskId);
        }
    },
    getters: {
        tasks: state => state.tasks
    }
});
