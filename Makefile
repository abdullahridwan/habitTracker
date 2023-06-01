
create:
	@echo "\033[1;32m (1/4) Logging into Firebase....\033[0m"
	$(MAKE) login
	@echo "\033[1;32m (2/4) Making your project....\033[0m"
	$(MAKE) start PROJECT_NAME=$(PROJECT_NAME)
	@echo "\033[1;32m (3/4) Now, on VSCODE, find all instances of 'promptdiary' and replace it with $(PROJECT_NAME) \033[0m"
	@echo "\033[1;32m (4/4) Then, go into your new flutter project and do `dart pub global activate flutterfire_cli` and `flutterfire configure`  \033[0m\n\n"



login: #Login to firebase
	firebase login

start: #gets the files from github
	pip3 install GitPython
	@echo "Starting the project: $(PROJECT_NAME)"
	flutter create $(PROJECT_NAME)
	python3 ./get_files.py
	mv ./$(PROJECT_NAME)/lib ./$(PROJECT_NAME)/lib_backup
	cp -r ./lib ./$(PROJECT_NAME)/   
	rm -rf ./lib       
	mv ./temp_dir/pubspec.yaml ./${PROJECT_NAME}/pubspec.yaml
	rm -rf ./temp_dir    

cleanup: 
	rm ./README.md
	rm get_files.py
	rm Makefile


# firebase-spin:
# 	dart pub global activate flutterfire_cli
# 	flutter pub add firebase_core
# 	flutter pub add firebase_auth
# 	flutter pub add cloud_firestore
# 	flutterfire configure



.DEFAULT_GOAL := create
