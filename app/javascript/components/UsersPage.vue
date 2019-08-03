<template>
  <div class="userscontainer">
    <div v-for="(result) in processedResults" :key="result.id" class="item">
         <h5>{{ result.name }}</h5>
         <img v-bind:src="require('../images/' + result.image_name)" class="image_test">
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
        results[i].url = ('../../../public/' + results[i].image_name)
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
  width: 100px;
}
.userscontainer {
  display: flex;
  flex-wrap: wrap;
  margin: auto;
  margin-left: 70px;
}
.item {
  width: 300px;
  height: 300px;
  border: 5px solid #f5fbff;
  background-color: #fff;
}

</style>
