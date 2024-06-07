#/bin/bash

counter=1
while true; do
  files=$(git ls-files --others --exclude-standard | head -500)
  if [[ -z "$files" ]]; then
    echo "No more untracked files to add."
    break
  fi
  echo "$files" | xargs git add
  count=$(echo "$files" | wc -l | xargs)
  echo "Added $count files to staging."
  
  # Commit the added files
  git commit -m "Batch commit #$counter of untracked files"
  echo "Committed batch #$counter."
  
  # Push the commit to the remote repository
  git push origin main
  echo "Pushed batch #$counter to remote repository."
  
  ((counter++))
done
