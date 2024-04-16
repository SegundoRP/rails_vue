<template>
  <div class="modal fade" id="detailsModal" tabindex="-1" aria-labelledby="detailsModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <h1 class="modal-title fs-5 mb-3" id="exampleModalLabel">Settings</h1>

        <div class="mb-3">
          <label class="me-2" for="page">Page</label>
          <input class="me-2" id="page" type="number" v-model="page">
        </div>

        <div class="mb-3">
          <label class="me-2" for="per_page">Per-page</label>
          <input class="me-2" id="per_page" type="number" v-model="perPage">
        </div>

        <div>
          <p>Filters</p>
          <template v-for="filter in filters" :key="filter">
            <input class="me-2" :id="filter" type="checkbox" :value="filter" v-model="valueFilters">
            <label class="me-2" :for="filter">{{ filter }}</label>
          </template>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" @click="applyFilters" data-bs-dismiss="modal">Apply settings</button>
      </div>
    </div>
  </div>
</div>
</template>

<script>
  import { mapMutations } from 'vuex';

  export default {
    props: {
      url: {
        type: String,
        required: true
      }
    },

    data() {
      return {
        page: null,
        perPage: null,
        filters: ['md', 'ml', 'ms', 'mw', 'me', 'mi', 'mb', 'mlg'],
        valueFilters: []
      };
    },

    methods: {
      ...mapMutations(['setEarthquakes']),

      async applyFilters() {
        let apiUrl = `${this.url}?page=${this.page}&per_page=${this.perPage}`;
        if (this.valueFilters.length > 0) {
          apiUrl += `&mag_type[]=${this.valueFilters.join('&mag_type[]=')}`;
        }
        const response = await fetch(apiUrl);
        const data = await response.json();

        this.setEarthquakes(data.data);
        this.page = '';
        this.perPage = '';
        this.valueFilters = [];
      }
    }
  }
</script>
