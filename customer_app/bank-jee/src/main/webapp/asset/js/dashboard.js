const swiperFirst = new Swiper(".swiper-first", {
    direction: "horizontal",
    spaceBetween: 30,
    slidesPerView: 1,
    breakpoints: {
        540: {
            slidesPerView: 2,
            spaceBetween: 15,
        },
        1200: {
            slidesPerView: 3,
            spaceBetween: 30,
        },
    },
    pagination: {
        el: ".swiper-pagination-first",
        type: "bullets",
        clickable: true,
    },
});

const swiperSecond = new Swiper(".swiper-second", {
    direction: "horizontal",
    spaceBetween: 30,
    slidesPerView: 1,
    breakpoints: {
        540: {
            slidesPerView: 2,
            spaceBetween: 15,
        },
        1200: {
            slidesPerView: 3,
            spaceBetween: 30,
        },
    },
    pagination: {
        el: ".swiper-pagination-second",
        type: "bullets",
        clickable: true,
    },
});
