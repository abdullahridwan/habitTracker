1. Run make create PROJECT_NAME=<some project name>
    this will automatically log you into firebase
    Create a flutter project based on that name
    Bring in relevant files

2. On VSCODE or whatever IDE, replace all instances of 'jill' with <some project name> 
3. cd into your new flutter project and run
    - `dart pub global activate flutterfire_cli`
    - `flutterfire configure`
4. Login to Firebase on your browser. Then, go on the firebase project and enable login with email and password. Now you're done!