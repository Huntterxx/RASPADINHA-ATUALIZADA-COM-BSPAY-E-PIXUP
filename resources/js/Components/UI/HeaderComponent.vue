<template>
    <div class="header-title flex justify-between">
        <h1 class="mb-4 text-3xl leading-none  text-gray-900 md:text-3xl lg:text-3xl dark:text-white">
            <slot class="ml-10" name="header"></slot>
        </h1>
<br><br>
        

        <slot></slot>
    </div>
</template>

<script>
export default {
    name: "headerComponent",
    data() {
        return {

        };
    },
    methods: {

    },
    mounted() {

    }
}
</script>

<style scoped>

</style>
