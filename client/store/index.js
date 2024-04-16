// import { createStore } from 'vuex';

// export default createStore({
//   state: {
//     // Define tus estados aquí
//   },
//   mutations: {
//     // Define tus mutaciones aquí
//   },
//   actions: {
//     // Define tus acciones aquí
//   },
//   getters: {
//     // Define tus getters aquí
//   }
// });

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
