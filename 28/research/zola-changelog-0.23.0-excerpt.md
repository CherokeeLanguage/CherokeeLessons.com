# Excerpt: zola CHANGELOG.md, section 0.23.0 (2026-08-05) — fetched live 2026-11-11 from
# https://raw.githubusercontent.com/getzola/zola/master/CHANGELOG.md

## 0.23.0 (2026-08-05)

This is probably the most breaking version of Zola that will happen. 
Depending on how you use it though, it might not be too long to migrate. It took about 20 minutes to upgrade the Zola docs
and it was mostly because it contains a lot of Tera syntax (as we will see later).

### Breaking
### Breaking

- remove `native-tls` feature to build zola
- `get_page` and `get_section` no longer work with paths containing language code, eg "content/some.fr.md". Use the canonical path + `lang` argument
- Tera, the template engine, has been updated to v2. See its own migration guide: <https://github.com/Keats/tera/blob/master/MIGRATION.md>
- shortcodes have been removed, see Migration section below for more details

#### Migration

