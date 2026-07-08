require "minitest/autorun"
require "yaml"

class SiteStructureTest < Minitest::Test
  ROOT = File.expand_path("..", __dir__)

  def path(*parts)
    File.join(ROOT, *parts)
  end

  def read(*parts)
    target = path(*parts)
    assert File.file?(target), "Expected #{File.join(*parts)} to exist"
    File.read(target)
  end

  def test_core_jekyll_files_exist
    %w[
      _config.yml
      Gemfile
      index.html
      README.md
      _data/navigation.yml
      _pages/about.md
      _pages/Notes.md
      _pages/Repositories.md
      _pages/Blogs.md
      _pages/Links.md
    ].each do |relative_path|
      assert File.file?(path(relative_path)), "Expected #{relative_path} to exist"
    end
  end

  def test_collections_are_configured
    config = YAML.safe_load(read("_config.yml"), aliases: true)
    collections = config.fetch("collections")

    %w[Notes Repositories Blogs Links].each do |collection|
      assert_equal true, collections.dig(collection, "output"), "#{collection} should output pages"
      assert_equal "/:collection/:path/", collections.dig(collection, "permalink")
    end
  end

  def test_navigation_links_match_public_pages
    navigation = YAML.safe_load(read("_data/navigation.yml"), aliases: true)
    links = navigation.fetch("main").map { |item| [item.fetch("title"), item.fetch("url")] }

    assert_equal [
      ["Notes", "/Notes/"],
      ["Repositories", "/Repositories/"],
      ["Blogs", "/Blogs/"],
      ["Links", "/Links/"]
    ], links
  end

  def test_archive_pages_render_their_collections
    {
      "Notes" => "_pages/Notes.md",
      "Repositories" => "_pages/Repositories.md",
      "Blogs" => "_pages/Blogs.md",
      "Links" => "_pages/Links.md"
    }.each do |collection, page|
      content = read(page)
      assert_includes content, "layout: archive"
      assert_includes content, "site.#{collection}"
      assert_includes content, "archive-single.html"
    end
  end

  def test_placeholder_collection_entries_exist
    {
      "_Notes/example-note.md" => "collection: Notes",
      "_Repositories/example-project.md" => "collection: Repositories",
      "_Blogs/example-post.md" => "collection: Blogs",
      "_Links/example-link.md" => "collection: Links"
    }.each do |relative_path, front_matter_line|
      assert File.file?(path(relative_path)), "Expected #{relative_path} to exist"
      assert_includes read(relative_path), front_matter_line
    end
  end

  def test_no_analytics_script_is_enabled_by_default
    Dir.glob(path("**", "*.{md,html,yml}")).each do |file|
      content = File.read(file)
      refute_includes content, "mapmyvisitors.com", "#{file} should not enable mapmyvisitors by default"
      refute_includes content, "tracking_id: UA-", "#{file} should not ship a default analytics ID"
    end
  end
end
