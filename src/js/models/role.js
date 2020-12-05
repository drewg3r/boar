const connection = require("../connection");
const Sequelize = require("sequelize");


const Model = Sequelize.Model;
class Role extends Model {}
Role.init({
    // attributes
    RoleId: {
        type: Sequelize.INTEGER,
        allowNull: false,
        primaryKey: true
    },
    Role: {
        type: Sequelize.STRING(45)
    }
}, {
    sequelize: connection,
    modelName: 'Role'
    // options
});

module.exports = Role;