const Sequelize = require('sequelize');

const options = {
    database: 'boar',
    username: 'root',
    password: 'toortoor',
    dialect: 'mysql',
    define: { timestamps: false }, // Це для того, щоб sequelize не додавав свої поля до таблиць, як createdAt або updatedAt.

    // Налаштування пулу з'єднань
    pool: {
        max: 5,
        idle: 30000,
        acquire: 60000,
    },
};

const sequelize = new Sequelize(options);

module.exports = sequelize;