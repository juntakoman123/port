<template>
  <div class="userscontainer">
    <div v-for="(result) in processedResults" :key="result.id" class="item">
         <img v-bind:src="require('../images/' + result.image_name)" class="image_test">
          <b-button variant="outline-primary" pill　class="button_test">フォローする</b-button>
         <div class="name">
          <router-link :to="{ name: 'UsersShow', params: { id: result.id } }" style="color: black;" >{{ result.name }}</router-link>
         </div>
         <div class="number_item">
          <div class="left">
            <p>ツイート</p>
            <div class="big">
              <router-link :to="{ name: 'UsersShow', params: { id: result.id } }" >{{ result.id }}</router-link>
            </div>
          </div>
          <div class="middle">
            <p>フォロー</p>
            <div class="big">
              <router-link :to="{ name: 'UsersFollowing', params: { id: result.id } }" >{{ result.id }}</router-link>
            </div>
          </div>
          <div class="right">
            <p>フォロワー</p>
            <div class="big">
              <router-link :to="{ name: 'UsersFollowers', params: { id: result.id } }" >{{ result.id }}</router-link>
            </div>
          </div>
        </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data: function () {
    return {
      users: []
    }
  },
  mounted () {
    this.updateUsers()
  },
  computed: {
    processedResults: function() {
      let results = this.users;
      for (let i = 0; i < results.length; i++) {
        results[i].url = ('/#/users/' + results[i].id)
      }
      return results;
    }
  },
  methods: {
    updateUsers: function() {
      axios.get('/api/users.json').then(response => (this.users = response.data))
    }
  }
}
</script>
<style scoped>
.image_test {
  width: 130px;
  margin-left: 10px;
  margin-top: 10px;
}
.userscontainer {
  display: flex;
  flex-wrap: wrap;
  margin: auto;
  margin-left: 70px;
  margin-top: 70px;
}
.item {
  width: 300px;
  height: 300px;
  border: 5px solid #f5fbff;
  background-color: #fff;
  position: relative;
}
.name {
  margin-left: 10px;
  font-size: 25px;
}
.button_test {
  position: absolute;
  right: 12px;
  bottom: 192px;
}
h3 {
  font-color: black;
}
.left {
  width:90px;
  position: absolute;
}
.middle {
  width:100px;
  position: absolute;
  left: 90px;
}
.right {
  width:100px;
  position: absolute;
  left: 180px;
}
.number_item {
  margin-top: 15px;
}
p {
  margin-left: 10px;
}
.number {
  font-size: 25px;
  margim-left: 5px;
}
.big {
  margin-left: 28px;
  font-size: 28px;
}
</style>
