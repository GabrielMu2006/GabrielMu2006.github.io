#!/usr/bin/env ruby
# frozen_string_literal: true

# Regenerates the downloadable copies under site/downloads/notes/ from the
# published notes in site/content/_Notes/ and their images in
# site/assets/images/notes/<slug>/.
#
# For each note this produces:
#   - site/downloads/notes/<slug>.md   (note body, front matter stripped)
#   - site/downloads/notes/<slug>.zip  (only when the note has images)
#
# The zip contains <slug>.md with image paths rewritten to a sibling images/
# directory, plus that images/ directory, so the note opens offline in
# Obsidian or Typora with working images.
#
# Run this after adding or editing a note. It is idempotent and also removes
# download files whose source note no longer exists.

require "fileutils"
require "tmpdir"

ROOT = File.expand_path("../..", __dir__)
NOTES_DIR = File.join(ROOT, "site", "content", "_Notes")
IMAGES_ROOT = File.join(ROOT, "site", "assets", "images", "notes")
DOWNLOADS_DIR = File.join(ROOT, "site", "downloads", "notes")

def strip_front_matter(content)
  content.sub(/\A---[ \t]*\r?\n.*?\r?\n---[ \t]*\r?\n/m, "")
end

FileUtils.mkdir_p(DOWNLOADS_DIR)

notes = Dir.glob(File.join(NOTES_DIR, "*.md")).sort
slugs = notes.map { |f| File.basename(f, ".md") }

# Remove stale download files whose source note no longer exists.
Dir.glob(File.join(DOWNLOADS_DIR, "*.{md,zip}")).each do |file|
  slug = File.basename(file).sub(/\.(md|zip)\z/, "")
  FileUtils.rm_f(file) unless slugs.include?(slug)
end

notes.each do |note|
  slug = File.basename(note, ".md")
  body = strip_front_matter(File.read(note)).strip + "\n"

  md_path = File.join(DOWNLOADS_DIR, "#{slug}.md")
  File.write(md_path, body)

  images_dir = File.join(IMAGES_ROOT, slug)
  images = Dir.glob(File.join(images_dir, "**", "*")).select { |p| File.file?(p) }
  zip_path = File.join(DOWNLOADS_DIR, "#{slug}.zip")

  if images.empty?
    FileUtils.rm_f(zip_path)
    puts "packaged #{slug}: #{File.basename(md_path)}"
    next
  end

  zip_body = body.gsub("/assets/images/notes/#{slug}/", "images/")

  Dir.mktmpdir("note-pkg-") do |tmp|
    zip_root = File.join(tmp, "note")
    FileUtils.mkdir_p(File.join(zip_root, "images"))

    File.write(File.join(zip_root, "#{slug}.md"), zip_body)

    images.each do |img|
      rel = img.delete_prefix("#{images_dir}/")
      dest = File.join(zip_root, "images", rel)
      FileUtils.mkdir_p(File.dirname(dest))
      FileUtils.cp(img, dest)
    end

    Dir.chdir(zip_root) do
      system("zip", "-qr", zip_path, "#{slug}.md", "images") or raise "zip failed for #{slug}"
    end
  end

  puts "packaged #{slug}: #{File.basename(md_path)} + #{File.basename(zip_path)} (#{images.size} image(s))"
end

puts "done: #{notes.size} note(s)"
