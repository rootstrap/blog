## Submitting an Idea

For the management of proposals and new ideas for blog posts, we use this repo's [issues](/issues). If you have an idea for an article, either you want to write it yourself or not, you can create a new issue describing it and tagging it accordingly depending on which category the article would fit in.

To make this process easier, we provide an issue template where we ask you for some basic information on your proposal: what’s the motivation for writing about the topic, some notes on the idea itself and possible keywords to identify the article with.

Once you create the issue, you can either assign it to yourself if you’re planning on writing the article, or you can leave it unassigned for anyone interested to pick it up. The blog maintainers will reach out to the reporter and assignee to further refine the idea and eventually decide to include it on a blog release.

**IMPORTANT:** We highly recommend you create an issue before starting to write an article. During the submitting process the idea may change a bit and new ideas may come up, causing the scope of the article to change. This is not to discourage you to start writing articles, but to be aware that changes may happen when going through the pipeline.

## Pushing your article for review

Once you decided to write an article, you can start working directly into the repository by creating a markdown formatted file in `content/<article-title> - <author-name>.md` and start writing!

When you think your article is ready to be reviewed, you can open up a Pull Request on the repo. The same as when creating an issue, you will have a basic template to follow and include some extra information about your article. It’s very important to include a reference to the originating issue to be able to keep a trace of the work being done on the blog.

At that point, one or more content reviewers will be assigned by the blog maintainers to the article. They will take care of reviewing the technical content of the article, making sure everything makes sense and nothing important is missing.
Once the content is reviewed and considerd ready for publishing, one last review will be done by Austin, who will make sure the grammar, structure and story telling of the article is top notch, taking care of enhancing it's readadbility and appeal.

Other than that, all the same practices we’re already following for [code reviews](https://github.com/rootstrap/tech-guides/tree/master/code-review) should be taken into account on this process.

Lastly, when the review process has been completed, your article will be merged into the repo, the originating issue will be closed, and your article will be scheduled to be released. To finish the process, you should work with the person in charge of the blog styling to work on your content and get it ready to be presented to the world!

## How to Use Labels

Usually issues will not need any labels, but still there are a few labels that can be used for them. An issue can be labeled with ![](https://img.shields.io/badge/low_hanging_fruit-d655af.svg) when it's an article that should be easy and fast to write. It can also be added the ![](https://img.shields.io/badge/duplicate-cfd3d7.svg) label if there has already been an article about the same subject, and it can be an ![](https://img.shields.io/badge/update-055c66.svg), when it's an update or enhacement to an already existing article.

Regarding pull requests, we have a few labels that define in which step of the process the article is. If the PR was created but it's a work in progress, you would add the ![](https://img.shields.io/badge/WIP-82abd8.svg) label, so that reviewers know that it's not the final result. After the assignee finished writing it, ![](https://img.shields.io/badge/content_review-c1db1a.svg) can be used so that its content can be reviewed. When this is done, ![](https://img.shields.io/badge/style_review-d4c5f9.svg) can be added so that the style of the article (grammar, diction, readability, appeal) can be assessed. Once all this is finished, the ![](https://img.shields.io/badge/ready-48eaa9.svg) label will be added, so that the PR can be merged into the repo and published. There are other labels that can be used throughout this process, which are ![](https://img.shields.io/badge/help_wanted-e5676d.svg), if the assignee needs any kind of help (whether someone to finish writing the article or just to clear out some doubts), and ![](https://img.shields.io/badge/on_hold-dee510.svg), in the case the article is not being worked on right now (for example if the person used to have more free time to do this but know is currently working on something with a higher priority). ![](https://img.shields.io/badge/low_hanging_fruit-d655af.svg) and ![](https://img.shields.io/badge/update-055c66.svg) also apply for PRs. 

## Notes

- Please, follow our [guide](https://github.com/rootstrap/blog/blob/master/GUIDE.md) to structure your post according to the standards we have defined.
