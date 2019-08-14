<template>
  <div id="app">
    <b-form @submit.prevent="updateUser()">
      <p>{{ message }}</p>
      <div class="card">
        <b-card bg-variant="light">
          <b-form-group
            label-cols-sm="4"
            label="名前:"
            label-align-sm="right"
            label-for="nested-city"
          >
            <b-form-input id="nested-city"
            :placeholder="myName" v-model="user.name"></b-form-input>
          </b-form-group>
          <b-form-group
            label-cols-sm="4"
            label="画像:"
            label-align-sm="right"
            label-for="nested-state"
          >
            <b-form-file v-model="user.image" class="mt-3" plain accept=".jpg, .png, .gif, .JPG" @change="getImage"></b-form-file>
          </b-form-group>
          <button type="submit" class="btn btn-primary right" :disabled="user.name === ''">送信</button>
        </b-card>
      </div>
    </b-form>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data: function () {
    return {
      message: "プロフィール編集",
      myName: "",
      user: {
        name: "",
        image: null
      }
    }
  },
  mounted: function() {
    this.MyName()
  },
  methods: {
    updateUser: function() {
      let data = new FormData;
      data.append('name', this.user.name);
      data.append('image', this.user.image);
      axios.patch('/api/settings', data)
        .then(response => {
        console.log("ok");
        this.MyName();
        })
        .catch(error => {
          console.log(error);
        })
    },
    MyName: function() {
      axios.get('/api/settings')
      .then(response => {
        this.myName = response.data
      })
      .catch(error => {
        console.error(error);
      })
    },
    getImage: function(event) {
      let file = event.target.file;
      this.user.image = file;
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
  width: 400px;
  margin: auto;
  font-size: 15px;
}
.right {
  margin-left: 300px;
}
.form-group {
  margin-left: -100px;
}
.error_message {

}

</style>
