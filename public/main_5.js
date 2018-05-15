const app = new Vue({
    el: "#app",
    data: {
        friends: ["Jack", "John"],
    },
    mounted() {
        fetch("http://rest.learncode.academy/api/vue-5/friends")
            .then(response => response.json())
            .then((data) => {
                this.friends = data;
            })
    },
    template: `
    <div>
        <li v-for="friend in friends">{{friend.name}}</li>
    </div>
    `
});