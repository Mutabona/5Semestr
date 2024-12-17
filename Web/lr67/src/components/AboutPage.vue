<template>
  <div class="about-me-container">
    <h1>Обо мне</h1>
    <p>Вот это вот я да</p>
    <p>Я сделал очень полезную страницу обо мне</p>
    <ul>
      <li>Это вот шестая и седьмая лабораторная</li>
      <li>Даже вот не знаю что написать</li>
      <li>Я просто хочу закрыть эту дисциплину</li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'AboutPage'
};
</script>

<style scoped>
.about-me-container {
  width: 100%;
  max-width: 600px;
  margin: 20px;
  padding: 20px;
  background: #f9f9f9;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  box-sizing: border-box;
}

h1 {
  margin-bottom: 20px;
}

p {
  margin-bottom: 10px;
}

ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

li {
  margin-bottom: 10px;
  font-size: 16px;
}
</style>