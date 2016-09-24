---
title: Third post
date: 2016-06-02
intro: The third post is about another topic.
tags: [tag3, tag4]
---

This post is also written in **Markdown**.

I recently decided to code a new simple website for myself (you’re looking at it). My old website was a simple static generated website, which is awesome for a lot of purposes. But I wanted my website to be more of a real application that I can use for more than simple blog posts. So I decided to implement it in Elixir using the Phoenix framework.

I still wanted to be able to write my blog posts using simple Markdown documents that I version control in Git. I prefer using static Markdown documents over content loaded from a database since I like using my normal code editor to write in, I get version control for free and I don’t have to think about an admin panel.

In this post I’m gonna share how I implemented a very simple static blog engine in Elixir with Markdown support.

We can put the Markdown files in the priv/posts folder. The name of each file will also be the slug on the website. Example: priv/posts/my-blog-post.md results in a blog post at http://example.com/my-blog-post.

If a post needs to refer to static assets, such as images, we can put them in web/static/assets/images and let Phoenix serve them.

We want every request to be as fast as possible, so we only want to render the Markdown files once. In other words we need to keep the compiled posts in memory somehow.

Alright, now let’s code some Elixir!

A link: [Sebastian Seilund](http://www.sebastianseilund.com)
