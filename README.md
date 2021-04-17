## Memebers
Shawn Mountenay, Shreyasi Chauhan, Eloise Espel, Shaya Selincourt 

## MyBlogPost
The MyBlogPost website will allow registered users to create their own blog and unregistered users to view blog postings. The goal is to produce a similar type service that allows users to register, post blogs and make comments on blog entries. The system will be required to support multiple users. Additionally, unregistered users must be able to view the content but will not be able to edit or comment on posts. Blog comments need to be updated in real time.

  
## Project setup

1) Switch branch to dev
2) Change your directory to vue-your-blog-cosc360/frontend
3) Run ``yarn install`` or ``npm install`` in command line
4) Run ``yarn serve`` or `` npm run serve`` to start up frontend on http://localhost:8080/
5) Install MySQL and open the Workbench. Within the workbench, create a new connection
6) Make sure username is root and the port number is 3306. Note the database name
7) Click "Store in Vault" and create a password. Note the password
8) Click test connection and ensure your database is online
9) If not, go to "Services" by searching it in the Windows search bar and check that MySQL80 is running. If it's not present, reinstall MySQL
10) Change your directory to vue-your-blog-cosc360/backend
11) Run ``npm install`` in command line
12) Create a ``.env`` file in /backend containing the following: ``DATABASE_URL=mysql://root:{your_db_password}@localhost:3306/{your_db_name}``
13) Run ``npx prisma generate`` to populate database with Prisma schema
14) Run ``npm run backend`` to start up the backend listener on http://localhost:3000/



## Features Implemented 
1) Wireframe including planned layout, elements, sizes, placement
2) Form validation with JavaScript
3) Data storage in MySQL
4) Responsive design philosophy
5) User images (thumbnail) and profile stored in database
6) Error handling

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).


COSC 360 Project Document 

 
 

 
 

 
 

Project Name: Vue Your Blog 

 
 

Team Members: 

 

Shawn Mountenay - 62247606 

Eloise Espel - 63799779 

Shreyasi Chauhan - 31282924 

Shaya Selincourt – 32399305 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

  

Project Description 

 

Team Members Selection 

Shreyasi: Documentation 

Shawn: Coding Main Features  

Shaya: Accessibility Features + Unit Testing + Unit Testing Documentation  

Eloise: Additional Website features + Unit Testing + Documentation 

 

Summary of the Project  

Vue Your Blog is a website that lets users create and view blogs on various topics. Users can sign in to post their thoughts and ideas on any topic they want and engage with the community in the comments sections. Our tech stack is Vue.js for the frontend framework, along with Vuetify which supplies a selection of prefab components such as buttons and app bars. For the backend, we are using a standard node.js server to collect API calls from the frontend and send it to the MySQL database. The API calls are created using Prisma, an object–relational mapping library to allow us to make database calls without writing SQL queries directly.   

Requirement List 

 

From meeting on 03/15/2021. 

 

Wireframe including planned layout, elements, sizes, placement 

Has columns, header and footer. 

 

Form validation with JavaScript 

Does not let the user submit the form is the data entered does not meet the safety requirements (e.g., username is unique, password is safe and so on). 

 

Data storage in MySQL and data queries with Prisma 

Stores users and posts allows for searching and modifications. The database is 	updated asynchronously following AJAX principles. 

 

Responsive design philosophy 

 The layout of the website changes depending on the user’s signed-in status or 	the action of the user (e.g., the user is writing a comment vs writing a post). 

 

User images (thumbnail) and profile stored in database 

The user profiles are stored and can be modified on the user’s profile page. 

 

Error handling 

Errors that occur during the operation of the website are caught in try/catch 	blocks and handled. 

 

Accessibility  

Ensure that text contrasts appropriately with the background and aria labels are 

used across any component so those using screen readers can utilize the site. 

 

Alert on page change 

The user gets an alert when they switch page to make sure they are aware (not 	in the middle of writing a new post or a comment). 

 

User Profile 

The user can see their profile and modify their username, email, password and 	profile picture.  

 

Search  

Users can search for posts in the search bar, the search bar scans the database 	and returns the results to the user.  

 

Admin  

The admin can search for post and users (by post title, username and/or email) 	and disable or enable users. This functionality is only available if the user is 	signed in as an admin (in database isAdmin = 1). 

 

 

 

Website Layout 

 

From meeting on 03/15/2021. 

Make the blog: 

 

Login page: 

Inserting image... 

Cards on hover: 

 

Cards on homepage (status: User is Not Signed-In): 

 

Cards on homepage (status: User is Signed-In): 

 

 

 
Site Map 

 

Site map from 03/16/2021 

 

User 

When the user first opens the website, they are prompt to sign in or register (they can still view posts). Once the user is registered or logged in, they can access the home page to view blog posts from other users. The user can also access the “Make a Blog” page to write a new post that will be sent to the homepage for other users to read. 

Admin 

When the admin first opens the website, they are prompt to sign in. The database checks that the user with this username and password as an isAdmin value of 1 (0 = isAdmin = false, 1=isAdmin=true). The admin can now go into admin page search for users and posts and enable and disable users. 

 

Server-side Summary 

When a user initiates a website feature that requires a database call, such as account registration or sign in RegisterForm.vue or SignInForm.vue, the input is sent to a JavaScript file called EventService.js in the scripts folder on the frontend that uses axios to send the appropriate HTTP request to the backend node.js server, which listens for incoming requests. When it receives a HTTP request, the server spins up an instance of express.js to send the data to the MySQL database after plugging in the HTTP request values into a Prisma schema. All Prisma queries can be found in index.js within the src folder in the backend. Instructions for spinning up the server can be found in the top-level project README.md.  
 

Limitations 

Does not work on Internet Explorer 

The site doesn’t have built in testing protocols yet 

A remote server hasn’t been set up for public deployment 

Admin users cannot remove posts or comments 

Password recovery is currently not implemented, users will have to contact admins directly 

 

Security and Validation 

All passwords are encrypted using the node backend library called bcrypt. We user this to hash a password once it arrives in the server, either to store it in the database, or to compare it to the value already in the database. Users who are not logged in or registered are also unable to access web pages such as a user’s profile or the admin menu. When a user registers, we ensure that the username and email hasn’t already been added to the database and they must agree to allow us to use their data for whatever we see fit.  

 

 

# Description of Files and Folders of the Code Base  

  

This project uses a simple client-server architecture, in which a client carries out actions in the browser, which make requests to the server when data requires accessing, creating, mutating or deleting. There are three main units of our client-server architecture. On the client-side, we have the View, and on the server-side, we have the Model and the Controller (MVC). Our three main libraries are VueJS for the View, ExpressJS, and Prisma for the Controller, and MySQL for the Model. VueJS runs on the client's computer, ExpressJS handles the requests and queries the MySQL database with Prisma.  

  

## Client Side  

On the client-side, the project has a component-based architecture. The files and folders are broken up into some main logical blocks. In the root of the project, there are various configuration files, for linting, formatting, git, and package management. There is a node_modules folder that contains dependencies of the project. There is a public folder that holds the index.html file, that has the app HTML, CSS, and JavaScript injected into it. The Source folder (src) is where most of the project code lies.   

  

The Source folder has an assets folder, which contains favicons that are referenced in the public folder’s index.html. The source folder has a main Javascript file, this is where we tell our project to run VueJS and add our plugins to it. The main plugins we have in the frontend are VueX, VueRouter, Vuetify, Vuelidate, TiptapVuetify, and Axios.   

  

VueX is the global state management plugin, it allows variables to be set and accessed globally across the project. VueX has a folder in the source folder called “store” with a single JavaScript file. VueRouter allows routes to be changed dynamically with JavaScript in the Vue code. VueRouter has a folder in the source folder called “routes” with a single JavaScript file.  Vuetify is a Google Material Design based component library that has attractive looking and feeling components such as tables, buttons, cards, and more. Vuetify has a configuration file inside the source in the plugins folder. Vuelidate is used to validate input fields dynamically. TipTapVuetify is a plugin for users to edit text. Vuelidate and TipTap Vuetify require no configuration files. Axios has a file in services that specifies how to make an HTTP request to the server (that is, which headers, protocols, and data formats to send and receive).   

  

The Vue Code is split up into three main logical units of components. At the top level is the App component. Below that are view components, which are found in the “views” folder, and below that are reusable components, and are found in the “components” folder.   

The App component, contains the NavBar, the Footer, and the Main section of the app. The NavBar and the Footer are mostly concerned with having links to URLs that switch the Main section of the App and change the route on click. However, the NavBar also has a search function on the home page.   

The view components are tied to a route and go inside the main section of the app component. For example, the sign-in page, the registration page, or the home page.  

  

The reusable components are components that are used either in the App component, the views components or in other reusable components. For example, the FormSubmitAndClear component is used in both the RegisterForm and the BlogForm components.   

  

## Server Side  

The server-side implements an asynchronous functional programming style, with many functions waiting to handle HTTP requests with ExpressJS, query the database with Prisma ( Prisma is our ORM (Object Relational Mapping library ) and send back appropriate responses. On the top level, there are configuration files for package management, linting, Git and environment variables. There is a folder with user/blog images in uploads. There is a Prisma folder that has a config file that specifies the schema of our Database so we can make Prisma Database calls. There is a node_modules folder that includes project dependencies. Furthermore, there is a source folder (src). Inside the source folder, we have a middleware folder that has a Multer configuration file (Multer is used to handle image uploads in the server directory). There is a JavaScript file in the source directory that has the bulk of our ExpressJS code. This is the file in which our code in which ExpressJS handles our HTTP requests, queries the DB with Prisma, and sends back responses to the client. 

 
 
 