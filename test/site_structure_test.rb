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

  def test_markdown_preserves_obsidian_style_line_breaks
    config = YAML.safe_load(read("_config.yml"), aliases: true)

    assert_equal true, config.dig("kramdown", "hard_wrap")
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

  def test_collection_directories_are_ready_for_content
    %w[
      _Notes
      _Repositories
      _Blogs
      _Links
    ].each do |relative_path|
      assert File.directory?(path(relative_path)), "Expected #{relative_path} to exist"
      assert File.file?(path(relative_path, ".gitkeep")), "Expected #{relative_path}/.gitkeep to exist"
    end
  end

  def test_no_analytics_script_is_enabled_by_default
    Dir.glob(path("**", "*.{md,html,yml}")).each do |file|
      content = File.read(file)
      refute_includes content, "mapmyvisitors.com", "#{file} should not enable mapmyvisitors by default"
      refute_includes content, "tracking_id: UA-", "#{file} should not ship a default analytics ID"
    end
  end

  def test_mathjax_is_configured_for_course_notes
    head = read("_includes/head.html")

    assert_includes head, "window.MathJax"
    assert_includes head, "inlineMath"
    assert_includes head, "tex-mml-chtml.js"
  end

  def test_obsidian_callout_support_is_present
    script = read("assets/js/main.js")
    styles = read("_sass/academic.scss")

    assert_includes script, "upgradeCallouts"
    assert_includes script, "[!"
    assert_includes styles, ".callout"
    assert_includes styles, ".callout__title"
  end

  def test_obsidian_callouts_preserve_rendered_line_breaks
    script = read("assets/js/main.js")

    refute_includes script, "first.textContent =", "Callout upgrade should preserve the rendered <br> nodes from kramdown"
    assert_includes script, "first.innerHTML"
  end

  def test_obsidian_foldable_callouts_are_supported
    script = read("assets/js/main.js")
    styles = read("_sass/academic.scss")

    assert_includes script, "callout--collapsible"
    assert_includes script, "aria-expanded"
    assert_includes script, "hidden"
    assert_includes styles, ".callout__toggle"
    assert_includes styles, ".callout__content"
  end

  def test_homepage_uses_personal_empty_states
    homepage = read("_pages/about.md")

    refute_includes homepage, "No blog posts published yet."
    refute_includes homepage, "Add Markdown files"
    refute_includes homepage, "_Blogs"
    refute_includes homepage, "home-panel--intro"
    refute_includes homepage, "A working notebook"
    assert_includes homepage, "SESS x EECS"
    assert_includes homepage, "Longer writing is still in the margins."
  end

  def test_lmfff_note_avoids_markdown_table_conflicts_in_inline_math
    note = read("_Notes/large-models-foundations-frontiers-lecture-1.md")

    refute_includes note, "$|V|$", "Use \\lvert V\\rvert so kramdown does not parse inline math as a table"
    assert_includes note, "\\lvert V\\rvert"
  end

  def test_lmfff_display_math_blocks_are_isolated
    lines = read("_Notes/large-models-foundations-frontiers-lecture-1.md").lines.map(&:chomp)
    in_math = false

    lines.each_with_index do |line, index|
      refute_match(/\A>?\s*\$\$.+\$\$\s*\z/, line.strip,
                   "Expected display math on line #{index + 1} to use multiline fences")
      next unless line.strip == "$$" || line.strip == "> $$"

      if in_math
        following = lines[index + 1].to_s.strip
        assert ["", ">"].include?(following),
               "Expected blank line after closing display math fence at line #{index + 1}"
        in_math = false
      else
        previous = lines[index - 1].to_s.strip
        assert ["", ">"].include?(previous),
               "Expected blank line before opening display math fence at line #{index + 1}"
        in_math = true
      end
    end

    refute in_math, "Expected display math fences to be balanced"
  end

  def test_lmfff_plain_text_does_not_continue_list_items
    lines = read("_Notes/large-models-foundations-frontiers-lecture-1.md").lines.map(&:chomp)

    lines.each_cons(2).with_index do |(previous, current), index|
      previous_text = previous.strip
      current_text = current.strip
      next unless previous_text.match?(/\A(?:[-*+] |\d+\. )/)
      next if current_text.empty?
      next if current.match?(/\A\s+\S/)
      next if current_text.match?(/\A(?:[-*+] |\d+\. )/)
      next if current_text.start_with?(">", "#", "|", "$$", "```")

      flunk "Expected blank line between list item at line #{index + 1} and plain text at line #{index + 2}"
    end
  end
end
