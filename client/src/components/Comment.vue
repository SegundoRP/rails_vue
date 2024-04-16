<template>
  <div class="modal fade" id="commentModal" tabindex="-1" aria-labelledby="commentModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <h1 class="modal-title fs-5 mb-3" id="exampleModalLabel">Deja tu comentario</h1>
        <div>
          <input type="text" v-model="comment">
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" @click="saveComment" data-bs-dismiss="modal">Save comment</button>
      </div>
    </div>
  </div>
</div>
</template>

<script>
  export default {
    props: {
      url: {
        type: String,
        required: true
      },

      id: {
        type: String,
        required: true
      }
    },

    data() {
      return {
        comment: ''
      };
    },

    methods: {
      async saveComment() {
        const response = await fetch(`${this.url}/${this.id}/comments`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            body: this.comment,
            feature_id: this.id
          })
        });
        const data = await response.json();
        this.comment = '';
      }
    }
  }
</script>
