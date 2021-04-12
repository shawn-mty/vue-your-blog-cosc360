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

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).
