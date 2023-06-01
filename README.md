Setup a project with Firebase, Onboarding screen, and authentication flow- fast.
There are 4 easy steps: 


# Step 1: Make the frontend and setup the scaffold for firebase
Run make create PROJECT_NAME=`some project name`
    this will automatically log you into firebase
    Create a flutter project based on that name
    Bring in relevant files

# Step 2: Make it your own
On VSCODE or whatever IDE, replace all instances of 'promptdiary' with `some project name` 

# Step 3: Scaffold to building: Making the firebase backend
cd into your new flutter project and run
    - `dart pub global activate flutterfire_cli`
    - `flutterfire configure`

# Step 4: Making sure users can login/signup
Login to Firebase on your browser. Then, go on the firebase project and enable login with email and password. Now you're done!