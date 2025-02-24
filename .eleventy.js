const markdownIt = require('markdown-it');
const markdownItAnchor = require('markdown-it-anchor');
const markdownItFootnote = require('markdown-it-footnote');

function trimAngleBrackets(url) {
    let begin = 0
    let end = url.length
    if (url[begin] === "<") {
        begin = 1
    }
    if (url[end - 1] === ">") {
        end = end - 1
    }
    if (begin >= end) {
        throw Error("Empty url")
    }
    return url.slice(begin, end)
}

const shortcodes = {
    newTabLink: (title, url) => {
        if (typeof url !== "string") {
            // The title _is_ the URL
            url = title;
        }
        if (url.length === 0) {
            throw Error("Empty url")
        }
        url = trimAngleBrackets(url)
        return `<a href="${url}" target="_blank" rel="noopener">${title}</a>`;
    },

    mastodonCommentsSection: (url) => {
        // For use in Markdown only. Generates a standard comments section at the end of a note with a post URL.
        const mastodonLink = shortcodes.newTabLink("Mastodon", "https://joinmastodon.org/");
        const postLink = shortcodes.newTabLink("my post on the Fediverse", url);
        return `## Comments?\n\nIf you have a ${mastodonLink} account, you can reply to ${postLink}.`;
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
