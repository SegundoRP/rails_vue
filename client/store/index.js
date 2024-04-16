import { createApp } from 'vue'
import { createStore } from 'vuex'
import vuex from 'vuex'

// Create a new store instance.
const store = createStore({
  state () {
    return {
      earthquakes: []
    }
  },
  mutations: {
    setEarthquakes(state, payload) {
      state.earthquakes = payload
    }
  }
})

export { store }
