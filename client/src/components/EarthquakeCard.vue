<template>
  <div>
    <button class="btn btn-primary mb-4"
            data-bs-toggle="modal" data-bs-target="#detailsModal">Configure details</button>

    <details-modal :url="apiUrl"></details-modal>

    <div class="row text-center card-content justify-content-center gap-3">
      <vue-awesome-paginate
      :total-items="totalItems"
      :items-per-page="itemsPerPage"
      :max-pages-shown="5"
      v-model="currentPage"
      :on-click="onClickHandler"
      class="justify-content-center"
      />

      <div class="col col-lg-3 card" v-for="earthquake in earthquakes" :key="earthquake.id">
        <div>
          <div>
            <div class="d-flex justify-content-between">
              <h5 class="title rounded-circle text-primary">#{{ earthquake.id }}</h5>
              <h5 class="title">{{ earthquake.attributes.title }}</h5>
            </div>
            <p class="subtitle"><span class="fw-semibold">External id:</span> {{ earthquake.attributes.external_id }}</p>
            <p class="subtitle"><span class="fw-semibold">Magnitude:</span> {{ earthquake.attributes.magnitude }}</p>
            <p class="subtitle"><span class="fw-semibold">Tsunami:</span> {{ earthquake.attributes.tsunami }}</p>
            <p class="subtitle"><span class="fw-semibold">Magnitude type:</span> {{ earthquake.attributes.mag_type }}</p>

            <button type="button" class="btn btn-primary"
                    data-bs-toggle="modal" data-bs-target="#commentModal"
                    @click="emitCommentId(earthquake.id)">Leave a comment</button>
            <comment :url="apiUrl" :id="commentId"></comment>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import DetailsModal from './DetailsModal.vue';
  import Comment from './Comment.vue';
  import { store } from '../../store/index.js'
  import { mapMutations, mapState } from 'vuex'

  export default {
    components: { DetailsModal, Comment },

    data() {
      return {
        currentPage: 1,
        totalItems: 10000,
        itemsPerPage: 1000,
        apiUrl: 'http://localhost:3000/api/features',
        commentId: ''
      };
    },

    mounted() {
      this.getEarthquakes();
    },

    computed: {
      ...mapState(['earthquakes']),
    },

    methods: {
      ...mapMutations(['setEarthquakes']),

      async getEarthquakes() {
        const response = await fetch(this.apiUrl);
        const data = await response.json();
        this.setEarthquakes(data.data)
        this.currentPage = data.pagination.current_page
        this.totalItems = data.pagination.total
        this.itemsPerPage = data.pagination.per_page
      },

      async onClickHandler(page) {
        const response = await fetch(`${this.apiUrl}/?page=${page}`);
        const data = await response.json();
        this.setEarthquakes(data.data);
      },

      emitCommentId(id) {
        this.commentId = id;
      }
    }
  }
</script>
