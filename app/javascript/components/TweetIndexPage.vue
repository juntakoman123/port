<template>
  <div id="tw">
    <div class="marge">
      <div class="item">
        <img :src="require('../../assets/images/' + login_user.image_name)" class="image_test">
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
              <router-link :to="{ name: 'UsersFollowing', params: { id: login_user.id} }" >{{login_user.follow_num}}</router-link>
            </div>
          </div>
          <div class="right">
            <p>フォロワー</p>
            <div class="big">
              <router-link :to="{ name: 'UsersFollowers', params: { id: login_user.id } }" >{{login_user.follower_num}}</router-link>
            </div>
          </div>
        </div>
      </div>

      <div class="tweet_main">
        <div class="update" v-on:click="updateTweets()"><span class="update_text">更新する</span></div>
        <div v-for="tweet in tweet_items" :key="tweet.id" class="tweet_item">
          <div>
            <div class="user_image">
              <img :src="require('../../assets/images/' + tweet.user_image_name)" class="user_image_item">
            </div>
            <div class="right_content">
              <div class="user_name">
                <router-link :to="{ name: 'UsersShow', params: { id: tweet.user_id } }" style="color: black; font-weight: bold;">{{ tweet.user_name }}</router-link>
              </div>
              <div class="tweet_content">
                {{tweet.content}}
              </div>
              <span v-if="tweet.fav === 'far'"class="fa-heart" :class="tweet.fav" v-on:click="addFavo(tweet.id)"> {{tweet.favo_num}}</span>
              <span v-else  class="fa-heart" :class="tweet.fav" v-on:click="deleteFavo(tweet.id)"> {{tweet.favo_num}}</span>
              <span class="time">{{tweet.created_at}}</span>
              <span class="fas fa-trash-alt trash" v-on:click="deleteTweet(tweet.id)" v-if="tweet.belongs === 'own'"></span>
            </div>
          </div>
        </div>
        <div class="spinner_box">
          <span class="spinner" v-if="spinner"><Spinner line-bg-color="#FFFFFF" /></span>
          <span class="end" v-else >これ以上取得できません</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

import Spinner from 'vue-simple-spinner'
import axios from 'axios'
export default {
  components: {
    Spinner
  },
  data: function () {
    return {
      tweets: [],
      login_user: {},
      tweet_items: [],
      offset: 20,
      spinner: true
    }
  },
  watch: {
    tweets: function() {
      this.$nextTick(function() {
        this.flesh();
      })
    }
  },

  created () {
    this.updateTweets();
  },
  mounted () {
    window.addEventListener('scroll', this.scrolly);
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
    },
    deleteTweet: function(tweet_id) {
      axios.delete(`/api/tweets/${tweet_id}`)
      .then(response => {
        console.log("delete");
        this.updateTweets();
      })
      .catch(error => {
        console.error(error)
      })
    },
    fetch: function (time) {
      var items = this.tweets.slice(this.offset,this.offset +20)
      if(this.offset >= this.tweets.length) {
        this.spinner = false
      }
      setTimeout(() => {this.tweet_items.push(...items)},time);
      this.offset += 20;
      console.log(this.offset)
    },
    scrolly: function () {
      if ((document.documentElement.scrollTop + document.body.clientHeight) - 68 >= document.body.scrollHeight) {
        this.fetch(1000);
      }
    },
    flesh: function () {
      this.tweet_items = this.tweets.slice(0,this.offset)
    }
  }
}
</script>

<style scoped>
.image_test {
  height: 130px;
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
  padding-bottom: 25px;
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
  text-indent: -0.05em;
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
.time {
  margin-left: 320px;
}
.update {
  background-color: white;
  border: 1px solid #f5fbff;
  height: 50px;
  font-size: 20px;
  color: #548fb9;
  text-align: center;
  position: relative;
}
.update:hover{
  background-color: #ebedef;
}
.update_text {
  position: absolute;
  top: 10px;
  right: 254px;
}
.trash {
  color: #c5c5c5;
}
.trash:hover {
  color: #fd6e8e;
  cursor : pointer;
}
.spinner {
  position: absolute;
  top: 10px;
  right: 280px;
}
.spinner_box {
  background-color: white;
  border: 1px solid #f5fbff;
  height: 50px;
  font-size: 20px;
  color: #548fb9;
  text-align: center;
  position: relative;
}
</style>
