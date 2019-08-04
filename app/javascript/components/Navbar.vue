<template>
<div>
  <b-navbar  type="dark" variant="dark" fixed="top">
    <b-navbar-nav>
      <b-nav-item href="/#/">ホーム</b-nav-item>
      <b-nav-item href="/#/users">ユーザー一覧</b-nav-item>
    </b-navbar-nav>

    <b-navbar-nav class="ml-auto">
      <b-button
      v-on:click="test()"
      pill
      variant="outline-warning">
      つぶやく
      </b-button>
        <b-nav-item-dropdown right>
          <template slot="button-content"><em>User</em></template>
          <b-dropdown-item href="#">プロフィール</b-dropdown-item>
          <b-dropdown-item href="/">サインアウト</b-dropdown-item>
        </b-nav-item-dropdown>
    </b-navbar-nav>
  </b-navbar>
</div>
</template>

<script>
import TweetModal from './TweetModal.vue'
export default {
  components: {
    TweetModal
  },
  methods: {
    test: function () {
      this.$emit('test')
    }
  }
}
</script>

<style scoped>
</style>
