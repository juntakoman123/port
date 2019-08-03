<template>
  <div id="app">
    <p>{{ message }}</p>
    <div class="spinner" v-if="spinner">
      <Spinner size="large" line-bg-color="black" />
    </div>



</div>


</template>

<script>

import Spinner from 'vue-simple-spinner'
export default {
  components: {
    Spinner
  },
  data: function () {
    return {
      message: "アカウントを作成しよう",
      spinner: false
    }
  },
  methods: {
    addSpinner: function() {
      this.spinner = true
    }
  }
}
</script>

<style scoped>
p{
  font-size: 2em;
  text-align: center;
  color: black;
  margin-top: 80px;
}
.spinner {
  margin-top: 20px;
}



</style>
