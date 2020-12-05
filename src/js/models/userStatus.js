const connection = require("../connection");
const Sequelize = require("sequelize");


const Model = Sequelize.Model;
class UserStatus extends Model {}
UserStatus.init({
    // attributes
    UserStatusId: {
        type: Sequelize.INTEGER,
        allowNull: false,
        primaryKey: true
    },
    Status: {
        type: Sequelize.STRING(45)
    }
}, {
    sequelize: connection,
    modelName: 'UserStatus'
    // options
});

module.exports = UserStatus;