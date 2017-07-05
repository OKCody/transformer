source general_functions.sh
source css_functions.sh
source conversion_functions.sh

html="false";
docx="false";
epub="false";
 pdf="false";
site="false";

function usage () {
  cat << EOF
  script_name=$0
Usage: ideal_textbook_creator [-b] [-p] [-e] [-d] [-s] [Markdown files]

    -b generates HTML document (body only)
    -d generates DOCX document
    -e generates EPUB document
    -p generates PDF  document
    -s generates stand-alone website

    -h displays this help information

EOF
  exit 0
}

while getopts ":bdeps" opt; do
  case $opt in
  b ) html="true";;
  d ) docx="true";;
  e ) epub="true";;
  p ) pdf="true";;
  s ) site="true";;
  \? ) usage;;
  esac
done
shift "$((OPTIND-1))" # perhaps not necessary
OPTIND=1              # perhaps not necessary

md_file=""    # empty list for appending markdown files
css_file=""   # empty list for appending stylesheet files
errors=0      # count number of errors encountered

# Accept .md/.MD and .css/.CSS file paths as arguments, separate into respective
# lists of files. Throw errors accordingly.
for file in $@; do
  check_file
  if [ "${type:0:4}" != "text" ]; then
    printf "ERROR: $file is empty or not of type 'text'.\n"
    errors+=1
  else
    if [ "${file: -3}" == ".md" ] || [ "${file: -3}" == ".MD" ]; then
      markdown_files+=" ${file:0:-3}.md"
    else
      if [ "${file: -4}" == ".css" ] || [ "${file: -4}" == ".CSS" ]; then
        stylesheet_files+=" ${file:0:-4}.css"
      else
        printf "ERROR: $file is not a supported file type.\n"
        printf "       Only '.md/.MD' and '.css/.CSS' files are supported.\n"
        printf "       File names should not contain spaces.\n"
        errors+=1
      fi
    fi
  fi
done

# If no errors exist, proceed
if [ $errors -gt 0 ]; then    # WEIRD... > is not recognized. Must use -gt instead. -_-
  echo "Errors exist. Use '-h' for help."
else

  # Lists files to be operated on
  echo ""
  echo " MD: "$markdown_files
  echo "CSS: "$stylesheet_files
  echo ""

  # Prepare format-specific stylesheets
  for css_file in $stylesheet_files; do
    make_html_css
    make_pdf_css
    make_epub_css
  done

  html_style="combo_html.css"
  pdf_style="combo_pdf.css"
  epub_style="combo_epub.css"

  for md_file in $markdown_files; do
    echo $md_file
    if [ $html == "true" ]; then
      printf "  --> ${md_file%md}html"
      to_html
      test_file "${md_file%md}html"
    fi
    if [ $pdf == "true" ]; then
      printf "  --> ${md_file%md}pdf"
      to_pdf
      test_file "${md_file%md}pdf"
    fi
    if [ $epub == "true" ]; then
      printf "  --> ${md_file%md}epub"
      to_epub
      test_file "${md_file%md}epub"
    fi
    if [ $docx == "true" ]; then
      printf "  --> ${md_file%md}docx"
      to_docx
      test_file "${md_file%md}docx"
    fi
  done
fi
