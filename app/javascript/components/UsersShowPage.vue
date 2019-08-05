<template>

<div>




<div class="marge">



  <div class="item">
       <img v-bind:src="require('../images/' + 'default.png')" class="image_test">

       <div class="name">
        <router-link :to="{ name: 'UsersShow', params: { id: 1 } }" style="color: black;" >1</router-link>
       </div>
       <div class="number_item">
        <div class="left">
          <p>ツイート</p>
          <div class="big">
            <router-link :to="{ name: 'UsersShow', params: { id: 1 } }" >1</router-link>
          </div>
        </div>
        <div class="middle">
          <p>フォロー</p>
          <div class="big">
            <router-link :to="{ name: 'UsersFollowing', params: { id: 1 } }" >1</router-link>
          </div>
        </div>
        <div class="right">
          <p>フォロワー</p>
          <div class="big">
            <router-link :to="{ name: 'UsersFollowers', params: { id: 1 } }" >1</router-link>
          </div>
        </div>
      </div>
  </div>


  <div class="tweet_main">

    <div v-for="tweet in processedResults" :key="tweet.id" class="tweet_item">
    <div>
      <div class="user_image">
        <img :src="require('../images/' + tweet.user_image_name)" class="user_image_item">
      </div>
      <div class="right_content">
        <div class="user_name">
          <router-link :to="{ name: 'UsersShow', params: { id: tweet.user_id } }" style="color: black; font-weight: bold;">{{ tweet.user_name }}</router-link>
        </div>
        <div class="tweet_content">
          {{tweet.content}}
        </div>
      </div>
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
      tweets: []
    }
  },
  mounted () {
    this.updateUsers();
    this.updateTweets();
  },
  computed: {
    processedResults: function() {
      let results = this.tweets
      for (let i = 0; i < results.length; i++) {
        var found = this.users.find(function(el) {
          return el.id === results[i].user_id
        })
        results[i].user_name = found.name;
        results[i].user_image_name = found.image_name
      }
      return results;
    }
  },
  methods: {
    updateUsers: function() {
      axios.get('/api/users.json').then(response => (this.users = response.data))
    },
    updateTweets: function() {
      axios.get('/api/tweets.json').then(response => (this.tweets = response.data))
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

.item {
  width: 300px;
  height: 300px;
  border: 5px solid #ffeeba;
  background-color: #fff;
  position: relative;
  float: left;
  margin-left: 260px;
}
.name {
  margin-left: 10px;
  font-size: 25px;
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

.tweet_main {
  width: 588px;
  margin-left: 580px;
  margin-top: 70px;
}

.tweet_item {
  background-color: white;
  border: 1px solid #f5fbff;
  position: relative;
}

.tweet_item:hover{
  background-color: #ebedef;
}

.user_image_item {
  width: 60px;
}

.user_image {
  position: absolute;
}

.right_content {
  margin-left: 70px;
  width: 500px;
  word-break: break-all;
}

.tweet_content {
  margin-bottom: 10px;
  text-indent: -0.25em;

}




</style>
