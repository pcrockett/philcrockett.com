const markdownIt = require('markdown-it');
const markdownItAnchor = require('markdown-it-anchor');

const markdownItOptions = {
    html: true, // you can include HTML tags in Markdown
    typographer: true
};

const markdownItAnchorOptions = {
    level: 1 // Add anchor IDs to header level 1 and greater
};

const shortcodes = {
    newTabLink: (title, url) => {
        if (typeof url !== "string") {
            // The title _is_ the URL
            url = title;
        }
        return `<a href="${url}" target="_blank" rel="noopener">${title}</a>`;
    },

    mastodonCommentsSection: (url) => {
        // For use in Markdown only. Generates a standard comments section at the end of a note with a post URL.
        const mastodonLink = shortcodes.newTabLink("Mastodon", "https://joinmastodon.org/")
        return `## Comments?\n\nIf you have a ${mastodonLink} account, you can reply to [my post on Mastodon](${url}).`;
    }
};

module.exports = function(eleventyConfig) {

    Object.keys(shortcodes).forEach(
        name => eleventyConfig.addShortcode(name, shortcodes[name])
    );

    eleventyConfig.addPassthroughCopy("src/assets");
    eleventyConfig.addPassthroughCopy({ "src/_files": "/" });

    // Thanks to:
    //
    // https://syntackle.live/blog/adding-custom-anchors-to-headings-in-markdown-eleventy-3NxBhIJO2OIr4XOj5LKc/
    //
    eleventyConfig.setLibrary(
        "md",
        markdownIt(markdownItOptions)
            .use(markdownItAnchor, markdownItAnchorOptions)
    );

    return {
        dir: {
            input: "src"
        },
        templateFormats: ["html", "liquid", "md" ]
    };
};
