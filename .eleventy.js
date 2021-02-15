module.exports = function(eleventyConfig) {

    eleventyConfig.addShortcode("newTabLink", (title, url) => {
        return `<a href="${url}" target="_blank" rel="noopener me">${title}</a>`;
    });

    return {
        dir: {
            input: "src"
        },
        templateFormats: ["html", "liquid", "md", "css", "ttf"]
    };
};
