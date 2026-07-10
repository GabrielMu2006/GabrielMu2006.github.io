# Custom Domain Design

## Goal

Bind `gabrielmu2006.cn` to the existing GitHub Pages site without changing the hosting provider or losing the default `gabrielmu2006.github.io` entry point.

## Domain Strategy

- Use `https://gabrielmu2006.cn` as the canonical site URL.
- Configure `www.gabrielmu2006.cn` as the `www` variant and let GitHub Pages redirect it to the apex domain.
- Keep `gabrielmu2006.github.io` available as the default GitHub Pages address; GitHub Pages should redirect it to the configured custom domain.
- Continue hosting the static Jekyll site on GitHub Pages. No server migration is involved.

## Repository Configuration

- Add a root-level `CNAME` file containing exactly `gabrielmu2006.cn`.
- Change `_config.yml` `url` to `https://gabrielmu2006.cn` and keep `baseurl` empty.
- Update `README.md` so the documented public URL and custom-domain instructions match the live configuration.
- Extend `test/site_structure_test.rb` to require the canonical URL and `CNAME` value.

## DNS Configuration

Configure the domain in Alibaba Cloud DNS with these records:

| Record type | Host record | Value |
| --- | --- | --- |
| A | `@` | `185.199.108.153` |
| A | `@` | `185.199.109.153` |
| A | `@` | `185.199.110.153` |
| A | `@` | `185.199.111.153` |
| CNAME | `www` | `GabrielMu2006.github.io` |

Use the provider's default routing line and an ordinary TTL. Do not add wildcard DNS records. Remove or replace conflicting `@` A/AAAA/CNAME records and conflicting `www` records only when they are clearly default parking records for this new domain; do not alter unrelated DNS records.

## Deployment Sequence

1. Commit and push the repository configuration so GitHub Pages knows the custom domain before public DNS points at it.
2. Configure the Alibaba Cloud DNS records.
3. Wait for DNS propagation and verify the apex A records and `www` CNAME.
4. Confirm GitHub Pages accepts the domain and enable **Enforce HTTPS** when the certificate becomes available.
5. Verify the apex URL, the `www` redirect, and the original GitHub Pages redirect without path loss.

## Failure Handling

- If Alibaba Cloud reports a record conflict, inspect the existing records before replacing anything.
- If GitHub reports that the domain is already taken, verify ownership and check whether another Pages repository has claimed it.
- If HTTPS is unavailable immediately, keep the DNS records in place and wait for certificate issuance; GitHub notes that this can take up to 24 hours.
- If DNS has not propagated, report the records that are still missing and do not claim the binding is complete.

## Verification

- Run `ruby test/site_structure_test.rb`.
- Run `bundle exec jekyll build`.
- Check `git diff --check` before committing.
- Query public DNS for the four apex A records and the `www` CNAME.
- Request all three public URLs and inspect redirect targets and HTTPS status.
