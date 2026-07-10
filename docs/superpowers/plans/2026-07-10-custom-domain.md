# Custom Domain Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make `https://gabrielmu2006.cn` the canonical URL for the existing GitHub Pages site, with working `www` and default-domain redirects.

**Architecture:** Declare the apex domain in the Jekyll source and repository `CNAME`, then point Alibaba Cloud DNS at GitHub Pages. Keep GitHub Pages as the host and verify public DNS, HTTPS, and redirects after deployment.

**Tech Stack:** Jekyll, GitHub Pages, Alibaba Cloud DNS, Ruby Minitest, DNS, HTTPS.

## Global Constraints

- Canonical URL: `https://gabrielmu2006.cn`.
- `www.gabrielmu2006.cn` must redirect to the apex domain.
- `gabrielmu2006.github.io` must remain a usable entry point and redirect to the custom domain.
- Do not add wildcard DNS records.
- Preserve unrelated Alibaba Cloud DNS records.
- Run `ruby test/site_structure_test.rb`, `bundle exec jekyll build`, and `git diff --check` before publishing.

---

### Task 1: Add a custom-domain regression test

**Files:**
- Modify: `test/site_structure_test.rb`

**Interfaces:**
- Consumes: `_config.yml` through `YAML.safe_load` and the root `CNAME` file through the existing `read` helper.
- Produces: a test that locks the canonical URL and CNAME value.

- [x] **Step 1: Add the failing test**

```ruby
def test_custom_domain_is_canonical
  config = YAML.safe_load(read("_config.yml"), aliases: true)

  assert_equal "https://gabrielmu2006.cn", config.fetch("url")
  assert_equal "", config.fetch("baseurl")
  assert_equal "gabrielmu2006.cn", read("CNAME").strip
end
```

- [x] **Step 2: Run the test suite and confirm the red state**

Run: `ruby test/site_structure_test.rb`

Expected: one failure because `_config.yml` still uses the GitHub domain or because `CNAME` does not exist.

### Task 2: Configure and publish the Jekyll source

**Files:**
- Create: `CNAME`
- Modify: `_config.yml`
- Modify: `README.md`
- Modify: `test/site_structure_test.rb`
- Modify: `docs/superpowers/plans/2026-07-10-custom-domain.md`

**Interfaces:**
- Consumes: the custom-domain regression test from Task 1.
- Produces: a GitHub Pages source tree whose canonical URL is `https://gabrielmu2006.cn`.

- [x] **Step 1: Add the domain declaration**

Create `CNAME` with exactly:

```text
gabrielmu2006.cn
```

Set the URL fields in `_config.yml` to:

```yaml
url: "https://gabrielmu2006.cn"
baseurl: ""
```

- [x] **Step 2: Update deployment documentation**

Document `https://gabrielmu2006.cn` as the public URL, keep `https://gabrielmu2006.github.io` as the default redirecting address, and record the Alibaba Cloud DNS values from the approved design.

- [x] **Step 3: Verify the source**

Run: `ruby test/site_structure_test.rb`

Expected: all tests pass.

Run: `bundle exec jekyll build`

Expected: Jekyll completes without Liquid or front matter errors.

Run: `git diff --check`

Expected: no output.

- [ ] **Step 4: Commit and push**

```bash
git add CNAME _config.yml README.md test/site_structure_test.rb docs/superpowers/plans/2026-07-10-custom-domain.md
git commit -m "Bind custom domain"
git push origin main
```

Expected: `origin/main` advances to the new commit.

### Task 3: Configure Alibaba Cloud DNS

**Files:**
- External state: Alibaba Cloud DNS records for `gabrielmu2006.cn`

**Interfaces:**
- Consumes: the GitHub Pages custom-domain declaration from Task 2.
- Produces: public apex and `www` DNS records pointing at GitHub Pages.

- [ ] **Step 1: Open the Alibaba Cloud DNS console**

Open the DNS record management page for `gabrielmu2006.cn`. If authentication is required, pause for the owner to log in without requesting or handling their password.

- [ ] **Step 2: Inspect conflicts**

Review existing `@` A/AAAA/CNAME and `www` records. Preserve unrelated records. Replace only default parking records that conflict with the approved GitHub Pages records.

- [ ] **Step 3: Add the apex records**

Add four records using the default routing line and the provider's ordinary TTL:

```text
A  @  185.199.108.153
A  @  185.199.109.153
A  @  185.199.110.153
A  @  185.199.111.153
```

- [ ] **Step 4: Add the www record**

```text
CNAME  www  GabrielMu2006.github.io
```

### Task 4: Verify DNS, HTTPS, and redirects

**Files:**
- External state: public DNS and GitHub Pages deployment

**Interfaces:**
- Consumes: repository and DNS configuration from Tasks 2 and 3.
- Produces: evidence that the custom domain is publicly usable.

- [ ] **Step 1: Verify public DNS**

Query the apex A records and `www` CNAME using public DNS. The apex must return all four `185.199.*.153` addresses and `www` must return `GabrielMu2006.github.io`.

- [ ] **Step 2: Check GitHub Pages HTTPS**

Open the repository's Pages settings. Enable **Enforce HTTPS** when GitHub makes the certificate available. If certificate issuance is pending, report that state without changing DNS.

- [ ] **Step 3: Verify public URLs**

Check:

```text
https://gabrielmu2006.cn/
https://www.gabrielmu2006.cn/
https://gabrielmu2006.github.io/
```

Expected: the apex serves the site over HTTPS, while `www` and the GitHub default address redirect to the apex without losing the requested path.
