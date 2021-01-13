
# goal: sync changes up from a commit from data-solutions to data-challenges
# assume only copiable files where impacted, not the solutions
# for example only README files

# usage
echo "🤖 usage:"
echo "- position yourself in data-solutions:"
echo "- . ./content_sync.sh ../data-challenges c2cd8589"
echo ""

# second parameter: target path for copy
target="${1}"

# first parameter: the sha of the commit from which to search for updated files
sha="${2}"

# list files updated by all the commits from $sha
updated_files="$(git diff --name-only $sha)"

# list changes
echo "😁 this script will launch the following commands:"
echo "${updated_files}" | while IFS= read -r line ; do echo "cp -rfv ${line} ${target}/${line}"; done

# ask for confirmation
echo ""
echo "😨 do you confirm ? (y/N)"
read -q confirmation

# launch copy
if [ $confirmation = "y" ]; then
  echo ""

  # copy files
  echo "${updated_files}" | while IFS= read -r line ; do \cp -rfv "${line}" "${target}/${line}"; done

  echo ""
  echo "🎉 success, see what happened:"
  echo "- cd ../data-challenges && git st"
else
  echo ""
  echo ""
  echo "😔 command cancelled"
fi
