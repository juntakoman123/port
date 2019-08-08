<template>
  <div>
    <div class="marge">
      <div class="item">
        <img :src="require('../images/' + login_user.image_name)" class="image_test">
        <div class="name">
          <router-link :to="{ name: 'UsersShow', params: { id: login_user.id } }" style="color: black;" >{{ login_user.name }}</router-link>
        </div>
        <div class="number_item">
          <div class="left">
            <p>ツイート</p>
            <div class="big">
              <router-link :to="{ name: 'UsersShow', params: { id: login_user.id } }" >{{ login_user.tweets_count }}</router-link>
            </div>
          </div>
          <div class="middle">
            <p>フォロー</p>
            <div class="big">
              <router-link :to="{ name: 'UsersFollowing', params: { id: login_user.id} }" >1</router-link>
            </div>
          </div>
          <div class="right">
            <p>フォロワー</p>
            <div class="big">
              <router-link :to="{ name: 'UsersFollowers', params: { id: login_user.id } }" >1</router-link>
            </div>
          </div>
        </div>
      </div>

      <div class="tweet_main">
        <div v-for="tweet in tweets" :key="tweet.id" class="tweet_item">
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
              <span v-if="tweet.fav === 'far'"class="fa-heart" :class="tweet.fav" v-on:click="addFavo(tweet.id)"> {{tweet.favo_num}}</span>
              <span v-if="tweet.fav === 'fas'" class="fa-heart" :class="tweet.fav" v-on:click="deleteFavo(tweet.id)"> {{tweet.favo_num}}</span>
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
      tweets: [],
      login_user: {}
    }
  },
  mounted () {
    this.updateTweets();
  },
    methods: {
    updateTweets: function() {
      axios.get('/api/tweets.json').then(response => {(this.tweets = response.data[0]);this.login_user = response.data[1]})
    },
    addFavo: function(tweet_id) {
      axios.post('/api/favorites', {id: tweet_id})
      .then(response => {
        console.log("ok");
        this.updateTweets();
      })
      .catch(error => {
        console.error(error)
      })
    },
    deleteFavo: function(tweet_id) {
      axios.delete(`/api/favorites/${tweet_id}`)
      .then(response => {
        console.log("delete");
        this.updateTweets();
      })
      .catch(error => {
        console.error(error)
      })
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
.far{
  color: #c5c5c5;
  font-size: 15px;
}
.far:hover{
  color: #fd6e8e;
  cursor : pointer;
}
.fas {
  color: #fd6e8e;
  font-size: 15px;
  cursor : pointer;
}
.span {
  float: left;
}
</style>
