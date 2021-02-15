module.exports = function(eleventyConfig) {
    return {
        dir: {
            input: "src"
        },
        templateFormats: ["html", "liquid", "md", "css", "ttf"]
    };
};
