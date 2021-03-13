

module.exports = {
  up: (queryInterface, Sequelize) => queryInterface.bulkInsert(
    'BlogEntries',
    [
      {
        title: 'Welcome to my blog',
        body: 'first persons blog bodybla bla bla bla bla bla bla bla bla bla bla bla',
        isAdmin: false,
      },
      {
        title: 'I am another persons blog, the admin',
        body: 'second persons blog body bla bla bla bla bla bla bla bla bla bla bla bla',
        isAdmin: true,
      },
    ],
    {},
  ),

  down: (queryInterface, Sequelize) => queryInterface.bulkDelete('BlogEntries', null, {}),
};
