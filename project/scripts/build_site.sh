#!/usr/bin/env bash
#
# Build the Jekyll site with a guaranteed UTF-8 locale.
#
# Why this wrapper exists: when a shell starts with LANG and LC_ALL unset,
# Ruby falls back to US-ASCII (Encoding.default_external), and Jekyll aborts
# with "invalid byte sequence in US-ASCII" while processing the site's
# Chinese content. Adding `encoding: utf-8` to site/_config.yml does not help,
# because the failure happens at the IO/encoding layer before that setting is
# applied. GitHub Actions runners are UTF-8 by default, so only local shells
# without a locale are affected.
#
# Usage:
#   bash project/scripts/build_site.sh            # build into _site
#   bash project/scripts/build_site.sh --trace    # extra args go to jekyll build
#
set -euo pipefail

cd "$(dirname "$0")/../.."

case "${LC_ALL:-${LANG:-}}" in
  *UTF-8* | *utf8* | *UTF8*) ;;
  *)
    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8
    ;;
esac

exec bundle exec jekyll build \
  --source site \
  --config site/_config.yml \
  --destination _site \
  "$@"
