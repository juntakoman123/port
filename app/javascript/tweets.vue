<template>
  <div id="app" v-cloak>
    <Navbar />
    <div>
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
import Vue from 'vue'
import VueRouter from 'vue-router'
import Navbar from './components/Navbar.vue'
import TweetIndexPage from './components/TweetIndexPage.vue'
import UsersPage from './components/UsersPage.vue'
import UsersLikePage from './components/UsersLikePage.vue'
import UsersShowPage from './components/UsersShowPage.vue'
import UsersFollowingPage from './components/UsersFollowingPage.vue'
import UsersFollowersPage from './components/UsersFollowersPage.vue'
import Setting from './components/Setting.vue'
import TimeLine from './components/TimeLine.vue'



const router = new VueRouter({
  routes: [
    { path: '/',
      component: TweetIndexPage },
    { path: '/users',
     component: UsersPage},
    { path: '/users/:id(\\d+)',
      name: 'UsersShow',
      component: UsersShowPage},
    { path: '/users/:id(\\d+)/likes',
      name: 'UsersLike',
      component: UsersLikePage},
    { path: '/users/:id(\\d+)/following',
      name: 'UsersFollowing',
      component: UsersFollowingPage},
    { path: '/users/:id(\\d+)/followers',
      name: 'UsersFollowers',
      component: UsersFollowersPage},
    { path: '/setting',
      name: 'Setting',
      component: Setting},
    { path: '/timeline',
      name: 'TimeLine',
      component: TimeLine}
  ]
})


Vue.use(VueRouter)
export default {
  router,
  components: {
    Navbar
  }
}
</script>

<style scoped>
[v-cloak] {
  display: none;
}
</style>
