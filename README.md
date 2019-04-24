## Submitting an Idea

For the management of proposals and new ideas for blog posts, we use this repo's [issues](/issues). If you have an idea for an article, either you want to write it yourself or not, you can create a new issue describing it and tagging it accordingly depending on which category the article would fit in.

To make this process easier, we provide an issue template where we ask you for some basic information on your proposal: what’s the motivation for writing about the topic, some notes on the idea itself and possible keywords to identify the article with.

Once you create the issue, you can either assign it to yourself if you’re planning on writing the article, or you can leave it unassigned for anyone interested to pick it up. Maintainers of the blog will reach out to the reporter and assignee to further refine the idea and eventually decide to include it on a release of the blog.

**IMPORTANT:** we highly recommend you create an issue before starting to write an article. During the submitting process the idea may change a bit and new ideas may come up, causing the scope of the article to change. This is not to discourage you to start writing articles, but to be aware that changes may happen when going through the pipeline.


## Pushing your article for review

Once you decided to write an article, you can start working directly into the repository by creating a markdown formatted file in `content/<category-of-your-article>/<article-title> - <author-name>.md` and start writing!

When you think your article is ready to be reviewed, you can open up a Pull Request on the repo. The same as when creating an issue, you will have a basic template to follow and include some extra information about your article. It’s very important to include a reference to the originating issue to be able to keep a trace of the work being done on the blog.

At that point, at least two reviewers will be assigned by the blog maintainers to the article:
  - A writing reviewer. They will take care of correcting the grammar, typos, storytelling and so on.
  - One or more content reviewers. They will take care of reviewing the technical content of the article, making sure everything makes sense and nothing important is missing.

Other than that, all the same practices we’re already following for [code reviews](https://github.com/rootstrap/tech-guides/tree/master/code-review) should be taken into account on this process.

Lastly, when the review process has been completed, your article will be merged into the repo, the originating issue will be closed, and your article will be scheduled to be released. To finish the process, you should work with the person in charge of the blog styling to work on your content and get it ready to be presented to the world!
