<template>
  <div id="app">
    <div v-if="errors.length != 0" class="error">
      <p style="color: red">{{ errors }}</p>
    </div>
    <b-form @submit.prevent="createSession()">
      <p>{{ message }}</p>
      <div class="card">
        <b-card bg-variant="light">
          <b-form-group
            label-cols-sm="4"
            label="Eメール:"
            label-align-sm="right"
            label-for="nested-city"
          >
            <b-form-input id="nested-city"
            placeholder="example.com" v-model="user.email"></b-form-input>
          </b-form-group>
          <b-form-group
            label-cols-sm="4"
            label="パスワード:"
            label-align-sm="right"
            label-for="nested-state"
          >
            <b-form-input id="nested-state"
            placeholder="password" type="password" v-model="user.pass">
            </b-form-input>
          </b-form-group>
          <button type="submit" class="btn btn-primary right">送信</button>
        </b-card>
          <b-button variant="info" class="guest" @click="guest()">ゲスト</b-button>
      </div>
    </b-form>

  </div>
</template>

<script>
import axios from 'axios'
export default {
  data: function () {
    return {
      message: "tweet appにログイン",
      user: {
        email: "",
        pass: ""
      },
      errors: ''
    }
  },
  methods: {
    createSession: function() {
      axios.post('/sessions', this.user)
        .then(response => {
          location.href = "/";
          console.log(e);
        })
        .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        })
    },
    guest: function() {
      this.user.email = "test@gmail.com";
      this.user.pass = "123123";
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
  position: relative;
}
.right {
  margin-left: 220px;
}
.error {
  font-size: 10px;
}
.guest {
  position: absolute;
  left: 160;
  top: 129;
}
</style>
