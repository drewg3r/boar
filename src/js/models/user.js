const connection = require("../connection");
const Sequelize = require("sequelize");


const Model = Sequelize.Model;
class User extends Model {}

User.init({
    // attributes
    UserId: {
        type: Sequelize.INTEGER,
        allowNull: false,
        primaryKey: true
    },
    username: {
        type: Sequelize.STRING(45),
        allowNull: false
    },
    password: {
        type: Sequelize.STRING(32),
        allowNull: false
    },
    email: {
        type: Sequelize.STRING(50),
        allowNull: false
    },
    avatar: {
        type: Sequelize.STRING(500)
    }
}, {
    sequelize: connection,
    modelName: 'User',
    tableName: "User",
    freezeTableName: true
    // options
});

module.exports = User;