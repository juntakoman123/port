<template>
  <div class="userscontainer">
    <div v-for="(result) in users" :key="result.id" class="item">
         <img v-bind:src="require('../images/' + result.user_image_name)" class="image_test">
          <b-button variant="outline-primary" pill　class="button_test" v-on:click="follow(result.id)" v-if="result.fd === 'no_follow'">フォローする</b-button>
          <b-button variant="primary" pill　class="button_test" v-on:click="remove(result.id)" v-if="result.fd === 'followed'" v-b-tooltip.hover.v-danger title="フォロー解除">{{ text }}</b-button>
         <div class="name">
          <router-link :to="{ name: 'UsersShow', params: { id: result.id } }" style="color: black;" >{{ result.user_name }}</router-link>
         </div>
         <div class="number_item">
          <div class="left">
            <p>ツイート</p>
            <div class="big">
              <router-link :to="{ name: 'UsersShow', params: { id: result.id } }" >{{ result.tweet_num }}</router-link>
            </div>
          </div>
          <div class="middle">
            <p>フォロー</p>
            <div class="big">
              <router-link :to="{ name: 'UsersFollowing', params: { id: result.id } }" >{{ result.follow_num }}</router-link>
            </div>
          </div>
          <div class="right">
            <p>フォロワー</p>
            <div class="big">
              <router-link :to="{ name: 'UsersFollowers', params: { id: result.id } }" >{{ result.follower_num }}</router-link>
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
      users: [],
      text: "フォロー中"
    }
  },
  mounted () {
    this.updateUsers()
  },
  methods: {
    updateUsers: function() {
      axios.get(`/api/followers/${this.$route.params.id}.json`).then(response => (this.users = response.data))
    },
    follow: function(user_id) {
      axios.post('/api/follows', {id: user_id})
      .then(response => {
        console.log("ok");
        this.updateUsers();
      })
      .catch(error => {
        console.error(error)
      })
    },
    remove: function(user_id) {
      axios.delete(`/api/follows/${user_id}`)
      .then(response => {
        console.log("delete");
        this.updateUsers();
      })
      .catch(error => {
        console.error(error)
      })
    },
    changeText: function() {
      this.text = "フォロー解除"
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
