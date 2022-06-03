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
            slidesPerView: 2,
            spaceBetween: 15,
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
            slidesPerView: 2,
            spaceBetween: 15,
        },
    },
    pagination: {
        el: ".swiper-pagination-second",
        type: "bullets",
        clickable: true,
    },
});

const swiperThird = new Swiper(".swiper-third", {
    direction: "horizontal",
    spaceBetween: 30,
    slidesPerView: 1,
    breakpoints: {
        540: {
            slidesPerView: 2,
            spaceBetween: 15,
        },
        768: {
            slidesPerView: 2,
            spaceBetween: 30,
        },
        1024: {
            slidesPerView: 3,
            spaceBetween: 60,
        },
        1200: {
            slidesPerView: 4,
            spaceBetween: 60,
        },
    },
    pagination: {
        el: ".swiper-pagination-third",
        type: "bullets",
        clickable: true,
    },
});
