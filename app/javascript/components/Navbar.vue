<template>
<div>
  <b-navbar  type="dark" variant="dark" fixed="top">
    <b-navbar-nav>
      <b-nav-item href="/#/">ホーム</b-nav-item>
      <b-nav-item href="/#/users">ユーザー一覧</b-nav-item>
      <b-nav-item href="/#/timeline">タイムライン</b-nav-item>
    </b-navbar-nav>

    <b-navbar-nav class="ml-auto">
      <b-button
      v-on:click="showModal = true"
      pill
      variant="outline-warning">
      つぶやく
      </b-button>
        <b-nav-item-dropdown right>
          <template slot="button-content"><em>User</em></template>
          <b-dropdown-item href="/#/setting">プロフィール</b-dropdown-item>
          <b-dropdown-item v-on:click="logout">サインアウト</b-dropdown-item>
        </b-nav-item-dropdown>
    </b-navbar-nav>
  </b-navbar>

  <modal v-if="showModal" @cancel="showModal = false" @ok="showModal = false">
    <div slot="header">つぶやく</div>
  </modal>

</div>
</template>

<script>
import axios from 'axios'
import Modal from './TweetModal.vue'
export default {
  components: {
    Modal
  },
  data: function() {
    return{
    showModal: false
    }
  },
  methods: {
    test: function () {
      this.$emit('test')
    },
    logout: function () {
      axios.delete('/sessions').then(response => {console.log("logout"); location.href = "/registrations/new" })
    }
  }
}
</script>

<style scoped>
</style>
