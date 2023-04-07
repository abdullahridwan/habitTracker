login: #Login to firebase
	firebase login

start: #gets the files from github
	flutter create $(PROJECT_NAME)
	python3 ./get_files.py
	mv ./$(PROJECT_NAME)/lib ./$(PROJECT_NAME)/lib_backup
	cp -r ./lib ./$(PROJECT_NAME)/   
	rm -rf ./lib       
	rm -rf ./temp_dir    
	cd $(PROJECT_NAME)

firebase-spin:
	dart pub global activate flutterfire_cli
	flutter pub add firebase_core
	flutter pub add firebase_auth
	flutter pub add cloud_firestore
	flutterfire configure