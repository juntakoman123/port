<template>
  <div id="app">
    <p>{{ message }}</p>
    <div class="spinner" v-if="spinner">
      <Spinner size="large" line-bg-color="black" />
    </div>
  <div class="card">
  <b-card bg-variant="light">
      <b-form-group
        label-cols-sm="4"
        label="Eメール:"
        label-align-sm="right"
        label-for="nested-city"
      >
        <b-form-input id="nested-city"
        placeholder="example.com"></b-form-input>
      </b-form-group>
      <b-form-group
        label-cols-sm="4"
        label="パスワード:"
        label-align-sm="right"
        label-for="nested-state"
      >
        <b-form-input id="nested-state"
        placeholder="password" type="password"></b-form-input>
      </b-form-group>
      <button type="submit" class="btn btn-primary right">送信</button>
  </b-card>
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
      message: "tweet appにログイン",
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
.card {
  heigth: 350px;
  width: 340px;
  margin: auto;
  font-size: 15px;
}
.right {
  margin-left: 220px;
}

</style>
