const app = new Vue({
    el: "#app",
    data: {
        bobby: {
            first: 'Boddy',
            last: 'Bone',
            age: 25,
        },
        john: {
            first: 'John',
            last: 'Body',
            age: 30,
        }
    },
    computed: {
        /*bobbyFullName() {
            return `${this.bobby.first} ${this.bobby.last}`
        },
        johnFullName() {
            return `${this.john.first} ${this.john.last}`
        },*/
    },
    filters: {
        fullName(value) {
            return `${value.first} ${value.last}`;
        },
        ageInOneYear(age) {
            return age + 1;
        }
    },
    template: `
        <div>
            <h4>name: {{bobby | fullName}}</h4>
            <h4>age: {{bobby.age | ageInOneYear}}</h4>
            <h4>name: {{john | fullName}}</h4>
            <h4>age: {{john.age | ageInOneYear}}</h4>
        </div>
    `
});