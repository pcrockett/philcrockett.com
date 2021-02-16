module.exports = function(eleventyConfig) {

    eleventyConfig.addShortcode("newTabLink", (title, url) => {
        return `<a href="${url}" target="_blank" rel="noopener">${title}</a>`;
    });

    eleventyConfig.addPassthroughCopy("src/assets");
    eleventyConfig.addPassthroughCopy({ "src/_files": "/" });

    return {
        dir: {
            input: "src"
        },
        templateFormats: ["html", "liquid", "md" ]
    };
};
