### To delete all records from db:
SET FOREIGN_KEY_CHECKS = 0; 
TRUNCATE blog_headers;
TRUNCATE blog_imagepaths;
TRUNCATE blog_textareas;
TRUNCATE blog;
TRUNCATE post;
TRUNCATE profile;
TRUNCATE user;
SET FOREIGN_KEY_CHECKS = 1;