
# goal:
#
# sync changes up from a commit from data-solutions to data-challenges
#
# assumptions:
#
# - both repositories are checkout to the correct branch
# - all the modified files are part of the solution and of the challenges
# (every updated files are litteraly copied to the corresponding data-challenges directory)
# typically you want to use this with changes applied only to README files
# select the git hash accordingly

# usage
echo "🤖 usage:"
echo "- position yourself in data-solutions:"
echo "- checkout the correct branch in data-solutions and data-challenges"
echo "- provide the path to data-challenges and the commit to lookup as parameters:"
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
  echo "- cd ${target} && git st"
else
  echo ""
  echo ""
  echo "😔 command cancelled"
fi
