const markdownIt = require('markdown-it');
const markdownItAnchor = require('markdown-it-anchor');
const markdownItFootnote = require('markdown-it-footnote');

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

const markdownPlugins = [

    (config) => {
        // Thanks to:
        //
        // https://syntackle.live/blog/adding-custom-anchors-to-headings-in-markdown-eleventy-3NxBhIJO2OIr4XOj5LKc/
        //
        return config.use(markdownItAnchor, {
            level: 1 // Add anchor IDs to header level 1 and greater
        });
    },

    (config) => {
        config = config.use(markdownItFootnote);
        config.renderer.rules.footnote_block_open = () => {
            return '<h2 id="footnotes">Footnotes</h2>\n' +
            '<section class="footnotes">\n' +
            '<ol class="footnotes-list">\n';
        };
        return config;
    }
]

module.exports = function(eleventyConfig) {

    Object.keys(shortcodes).forEach(
        name => eleventyConfig.addShortcode(name, shortcodes[name])
    );

    eleventyConfig.addPassthroughCopy("src/assets");
    eleventyConfig.addPassthroughCopy({ "src/_files": "/" });

    let mdConfig = markdownIt({
        html: true, // you can include HTML tags in Markdown
        typographer: true // features like smart quotes
    });
    mdConfig = markdownPlugins.reduce((config, configFn) => configFn(config), mdConfig);
    eleventyConfig.setLibrary("md", mdConfig);

    return {
        dir: {
            input: "src"
        },
        templateFormats: ["html", "liquid", "md" ]
    };
};
