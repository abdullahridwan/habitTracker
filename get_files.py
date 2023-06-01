import os
import shutil
import git

repo_url = "https://github.com/abdullahridwan/flutter_template.git"
folder_path = "./lib"

# Clone the repository to a temporary directory
temp_dir = git.Repo.clone_from(repo_url, "temp_dir", branch='main')

# Get the path to the specific folder in the repository
folder_repo_path = temp_dir.working_tree_dir + "/" + folder_path

# Copy the folder to a destination directory
shutil.copytree(folder_repo_path, "lib")


