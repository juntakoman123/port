<template>
  <div id="app">
    <p>{{ message }}</p>
    <div class="button_wrapper">
      <b-button
        size="lg"
        v-on:click="addSpinner()"
        pill
        variant="outline-primary"
        href="/sessions/new">
        ログイン
      </b-button>
      <b-button
        size="lg"
        v-on:click="addSpinner()"
        pill
        variant="outline-primary"
        href="/signups/new">
        アカウント作成
      </b-button>
    </div>
    <Anime v-if="anime"/>
    <div class="spinner" v-if="spinner">
      <Spinner size="large" line-bg-color="black" />
    </div>
  </div>
</template>

<script>
import Anime from './components/Anime.vue'
import Spinner from 'vue-simple-spinner'
export default {
  components: {
    Anime,
    Spinner
  },
  data: function () {
    return {
      message: "Hello tweet app!",
      messege2: "さあ、始めよう！",
      anime: false,
      spinner: false
    }
  },
  mounted: function() {
    setTimeout(this.timeAnime, 2000);
  },
  methods: {
    timeAnime: function() {
      this.anime = true
    },
    addSpinner: function() {
      this.spinner = true
    }
  }
}
</script>
<style scoped>
p{
  font-size: 3em;
  text-align: center;
  color: white;
  margin-top: 80px;
}
.button_wrapper{
   text-align:center;
   margin-top: 20px;
}
.spinner {
  margin-top: 20px;
}
</style>
