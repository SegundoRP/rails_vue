import { createApp } from 'vue'
import './style.css'
import App from './App.vue'
import { store } from '../store/index.js'

import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap/dist/js/bootstrap.min";

import VueAwesomePaginate from "vue-awesome-paginate";
import "vue-awesome-paginate/dist/style.css";

// createApp(App).mount('#app')
const app = createApp(App)
app.use(store)
app.use(VueAwesomePaginate)
app.mount("#app");
