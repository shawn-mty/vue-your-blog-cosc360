

module.exports = (sequelize, DataTypes) => {
  const BlogEntry = sequelize.define(
    'BlogEntry',
    {
      title: {
        type: DataTypes.STRING,
        allowNull: false,
      },

      body: {
        type: DataTypes.STRING,
        allowNull: false,
      },

      isAdmin: {
        type: DataTypes.BOOLEAN,
        defaultValue: false,
      },

    },

  );
  BlogEntry.associate = function (models) {
    // associations can be defined here
  };
  return BlogEntry;
};
