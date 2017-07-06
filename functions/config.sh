# Path to put output files
output=$(pwd)

# Paths to foundational stylesheets

# These stylesheets are necessary to yeild reasonable results such that users
# need only provide a minimal amount of CSS. If a user perfers not to provide
# CSS $example will be use.

# If a user does provide CSS, it must be named "html.css", "pdf.css", or
# "epub.css" in order to be applied to those respective output formats,
# otherwise $example will be applied.

# $base is the most basic stylesheet. Contains normalize.css and skeleton.css
# getskeleton.com or https://github.com/dhg/Skeleton
base="stylesheets/base.css"

# $example contains default colors, fonts, and other superficial attributes.
example="stylesheets/example.css"

# $base_html contains margins, break rules, and other important, html-specific
# attributes.
base_html="stylesheets/base_html.css"

# $base_pdf contains margins, break rules, and other important, pdf-specific
# attributes.
base_pdf="stylesheets/base_pdf.css"

# $base_epub contains margins, break rules, and other important, epub-specific
# attributes.
base_epub="stylesheets/base_epub.css"
