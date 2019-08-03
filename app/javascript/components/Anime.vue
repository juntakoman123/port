<template>
  <div class="TextAnime1">
    <span
      v-for="(t, index) in text"
      :key="index"
      class="item"
      :style="{animationDelay: index*100+'ms'}"
      v-text="t"
      />
  </div>
</template>

<script>
export default {
  data() {
    return {
      text: 'さぁ始めよう！'
    }
  }
}
</script>

<style scoped>
@keyframes text-in {
  0% {
    transform: translate(0, -20px);
    opacity: 0;
  }
}
.item {
  display: inline-block;
  min-width: 0.3em;
  font-size: 3rem;
  animation: text-in .8s cubic-bezier(0.22, 0.15, 0.25, 1.43) 0s backwards;
}
.TextAnime1 {
  color: white;
  text-align:center;
  margin-top: 30px;
}
</style>
