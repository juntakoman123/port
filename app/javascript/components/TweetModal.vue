<template>
  <transition name="modal">
    <div class="modal-mask" @click.self="$emit('cancel')">
      <div class="modal-wrapper">
        <div class="modal-container">
          <div class="modal-header">
            <slot name="header">
            </slot>
          </div>
          <div class="modal-body">
            <b-form @submit.prevent="createTweet()">
              <b-form-textarea
              id="textarea"
              v-model="text"
              placeholder="つぶやいてみよう"
              rows="3"
              max-rows="6"
              >
              </b-form-textarea>
              <b-button
              pill
              type="submit"
              variant="outline-primary"
              v-bind:disabled="text === '' || text.length > 140"
              class="tweet_button">
              つぶやく
              </b-button>
            </b-form>
          </div>
        </div>
      </div>
    </div>
  </transition>
</template>

<script>
import axios from 'axios'
export default {
data: function() {
  return {
    text: ""
  }
},
methods: {
  createTweet: function () {
    axios.post('/api/tweets', {text: this.text})
    .then(response => {
      console.log("ok");
      this.$emit('ok');
    })
    .catch(error => {
      console.error(error);
    })
  }
}

}
</script>

<style scoped>
.modal-mask {
  position: fixed;
  z-index: 30;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  transition: opacity .3s ease;
}
.modal-container {
  width: 580px;
  margin: 0px auto;
  padding: 20px 30px;
  background-color: #fff;
  border-radius: 10px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, .33);
  transition: all .3s ease;
}
.modal-header {
  font-size: 20px;
}
.modal-default-button {
  float: right;
}
.modal-enter .modal-container,
.modal-leave-active .modal-container {
  -webkit-transform: scale(1.1);
  transform: scale(1.1);
}
.tweet_button {
  margin-left: 380px;
  margin-top: 5px;
}
</style>
