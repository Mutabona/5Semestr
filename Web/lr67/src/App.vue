<template>
  <div id="app">
    <nav>
      <router-link to="/">Очень полезная форма</router-link>
      <router-link to="/tasks">Задачки</router-link>
      <router-link to="/about">Обо мне</router-link>
    </nav>
    <div class="content">
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
export default {
  name: 'App'
};
</script>

<style>
body {
  font-family: "Comic Sans MS", cursive;
  background-color: #f4f4f9;
  margin: 0;
  padding: 0;
  height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
}

#app {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
}

nav {
  display: flex;
  gap: 20px;
  background-color: #007BFF;
  padding: 10px 20px;
  border-radius: 8px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
  margin: 0;
  width: 100%;
  justify-content: center;
  position: fixed;
  top: 0;
  z-index: 1000;
  text-decoration: none;
}

router-link {
  text-decoration: none;
  color: white;
  font-weight: bold;
  padding: 10px 15px;
  border-radius: 4px;
  background-color: #007BFF;
  display: inline-block;
  transition: background-color 0.3s ease;
}

.content {
  margin-top: 80px;
  flex: 1;
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
}

a {
  text-decoration: none;
  color: white;
}
</style>
