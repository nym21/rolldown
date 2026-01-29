#!/bin/bash

# Rolldown crates publishing script
# Ordered by dependency level (topological sort)
# Excludes crates with publish = false

cd crates

publish() {
  echo "Publishing $1..."
  cd "$1"
  cargo publish --allow-dirty --no-verify || true
  cd ..
}

# Level 0 - No internal dependencies
echo "=== Level 0 ==="
publish rolldown_devtools_action
publish rolldown_std_utils
publish rolldown_tracing
publish rolldown_workspace
publish string_wizard
publish rolldown_error
publish rolldown_fs

# Level 1
echo "=== Level 1 ==="
publish rolldown_ecmascript
publish rolldown_utils
publish rolldown_fs_watcher

# Level 2
echo "=== Level 2 ==="
publish rolldown_sourcemap
publish rolldown_devtools
publish rolldown_filter_analyzer

# Level 3
echo "=== Level 3 ==="
publish rolldown_common

# Level 4
echo "=== Level 4 ==="
publish rolldown_ecmascript_utils
publish rolldown_resolver
publish rolldown_dev_common

# Level 5
echo "=== Level 5 ==="
publish rolldown_plugin

# Level 6 - Publishable plugins
echo "=== Level 6 ==="
publish rolldown_plugin_oxc_runtime
publish rolldown_plugin_replace
publish rolldown_plugin_esm_external_require
publish rolldown_plugin_hmr
publish rolldown_plugin_chunk_import_map
publish rolldown_plugin_data_uri
publish rolldown_plugin_isolated_declaration
publish rolldown_plugin_lazy_compilation

# Level 7
echo "=== Level 7 ==="
publish rolldown_plugin_utils

# Level 8 - Publishable plugins using plugin_utils
echo "=== Level 8 ==="
publish rolldown_plugin_vite_css
publish rolldown_plugin_vite_css_post
publish rolldown_plugin_vite_html
publish rolldown_plugin_vite_resolve

# Level 9 - Core bundler
echo "=== Level 9 ==="
publish rolldown

echo "Done!"
