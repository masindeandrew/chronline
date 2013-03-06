module ArticleHelper

  def byline(article, options={})
    authors = article.authors.sort_by(&:last_name)
    authors.map do |author|
      if options[:link]
        link_to author.name, articles_site_staff_path(author)
      else
        author.name
      end
    end.to_sentence.html_safe
  end

  def display_date(article, format="%B %-d, %Y")
    article.created_at.strftime(format)
  end

  def disqus_identifier(article)
    article.previous_id || "_#{article.id}"
  end

  def disqus_options(article)
    {
      production: Rails.env.production?,
      shortname: Settings.disqus.shortname,
      identifier: disqus_identifier(article),
      title: article.title,
      url: site_article_url(article),
    }.to_json
  end

  def permanent_article_url(article)
    slug = @article.slugs.last
    if slug.to_param.include?('/')
      site_article_url(slug, subdomain: :www)
    else
      site_article_deprecated_url(slug, subdomain: :www)
    end
  end

  def mailto_article(article)
    subject = "Duke Chronicle: #{article.title}"
    body = <<EOS


--------------------------------------------------------------------------------

Duke Chronicle

#{article.title}

#{byline(article)} | #{display_date(article)}

#{article.teaser}

Visit #{site_article_url(article)} for the full story.
EOS
    "mailto:?subject=#{subject}&body=#{URI.escape(body)}"
  end

  def search_options(facets)
    facets.map do |facet|
      ["#{facet[:value]} (#{facet[:count]})", facet[:lookup]]
    end
  end

end
